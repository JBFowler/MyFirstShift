Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations], :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'front#index'

  constraints(subdomain: "www") do
    get '/', to: 'front#index'
    devise_scope :user do
      get '/register', to: 'registrations#new'
      post'/register', to: 'registrations#create'
    end

    namespace :sign_in do
      get '/', to: 'organization#find_subdomain'
      get '/find', to: 'organization#find_user', as: :find_user
    end
  end

  constraints(Subdomain) do
    devise_scope :user do
      get '/', to: 'devise/sessions#new', as: :new_user_session
      post '/', to: 'devise/sessions#create', as: :user_session
      delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    end

    scope module: 'organizations' do
      namespace :admin do
      end
      
      get 'home', to: 'home#index'    
      # https://joetestcompany.slack.com/invite/MTQxMTYyMDEzMTA4LTE0ODcwNDkwMjMtODY5NDI2Mjk0Yg
      get 'join', to: 'users#new', as: :join_org
      resources :users, only: [:show]
    end
  end
end
