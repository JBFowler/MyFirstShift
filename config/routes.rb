Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations], :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints(subdomain: "www") do
    root to: 'front#index'
    
    scope module: 'organizations' do
      devise_scope :user do
        get '/register', to: 'registrations#new'
        post'/register', to: 'registrations#create'
      end
    end

    namespace :sign_in do
      get '/', to: 'organizations#find_subdomain'
      post '/', to: 'organizations#find_subdomain', as: :find_subdomain
      get '/find', to: 'organizations#find_user'
      post '/find', to: 'organizations#find_user', as: :find_user 
    end
  end

  constraints(Subdomain) do
    scope module: 'organizations' do
      devise_scope :user do
        root to: 'sessions#new'
        get '/', to: 'sessions#new', as: :new_user_session
        post '/', to: 'sessions#create', as: :session
        delete '/sign_out', to: 'sessions#destroy', as: :destroy_user_session
      end

      namespace :admin do
      end
      
      get 'home', to: 'home#index'
      # https://joetestcompany.slack.com/invite/MTQxMTYyMDEzMTA4LTE0ODcwNDkwMjMtODY5NDI2Mjk0Yg
      # resources :users, only: [:show]
    end
  end
end
