Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'front#index'

  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy' 

  resources :users, only: [:show]
  resources :organizations, only: [:index] do
    collection do
      get "join"
    end
  end
end
