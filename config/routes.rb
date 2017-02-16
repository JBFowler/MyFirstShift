Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'front#index'

  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'

  namespace :sign_in do
    get '/', to: 'organization#find_subdomain'
    get 'find', to: 'organization#find_user', as: :find_user
  end

  constraints(subdomain: "www") do
    get '/', to: 'front#index'
  end

  constraints(Subdomain) do
    scope module: 'organizations' do
      root to: 'sessions#new'
      
      post '/', to: 'sessions#create'
      get 'sign_out', to: 'sessions#destroy'

      namespace :admin do
      end
      
      get 'home', to: 'home#index'    
      # https://joetestcompany.slack.com/invite/MTQxMTYyMDEzMTA4LTE0ODcwNDkwMjMtODY5NDI2Mjk0Yg
      get 'join', to: 'users#new', as: :join_org
      resources :users, only: [:show]
    end
  end
end
