Rails.application.routes.draw do
  devise_for :admins, skip: [:sessions, :registrations]
  devise_for :users, skip: [:sessions, :registrations], :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #letter opener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  #Beginning of routes
  constraints(subdomain: "") do
    root to: 'front#index'

    namespace :sign_in do
      get '/', to: 'organizations#index'
      get '/find_subdomain', to: 'organizations#find_subdomain'
      get '/find', to: 'organizations#find_user'
      post '/send_notification', to: 'organizations#send_notification', as: :send_notification
    end
  end

  constraints(subdomain: "supernova") do
    devise_scope :admin do
      get 'sign_in', to: 'admin/sessions#new', as: :new_admin_session
      post 'sign_in', to: 'admin/sessions#create', as: :admin_session
      delete 'admin/sign_out', to: 'admin/sessions#destroy', as: :destroy_admin_session
    end

    namespace :admin do
      get '/home', to: 'home#index'

      resources :organizations do
        scope module: 'organizations' do
          resources :invites, except: [:show, :edit, :update]
        end
      end
    end
  end

  constraints(Subdomain) do
    scope module: 'organizations' do
      devise_scope :user do
        get '/', to: 'sessions#new', as: :new_user_session
        post '/', to: 'sessions#create', as: :user_session
        delete '/sign_out', to: 'sessions#destroy', as: :destroy_user_session
        get '/invite/:id', to: 'invites#show', as: :user_invite
        post '/invite/:id/redeem', to: 'invites#redeem', as: :redeem_invite
      end

      namespace :onboarding do
        get '/meet_the_management', to: 'onboarding#meet_the_management'
        get '/employee_info', to: 'onboarding#employee_info'
        post '/add_employee_info', to: 'onboarding#add_employee_info'
        # get '/user_info', to: 'users#'
      end

      namespace :owner do
        root to: 'home#index'
        get '/home', to: 'home#index'
        resources :invites, except: [:edit, :update]
      end

      resources :units do
        namespace :manager do
          get '/home', to: 'home#index'
        end
      end

      get '/home', to: 'home#index'
      get '/welcome', to: 'home#welcome'
    end
  end
end
