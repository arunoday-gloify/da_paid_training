Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication
  post   "auth/login"      => "auth#login"
  post   "auth/refresh"    => "auth#refresh"
  delete "auth/logout"     => "auth#logout"
  delete "auth/logout_all" => "auth#logout_all"

  # Current authenticated user (requires a valid access token)
  get "me" => "current_user#show"

  # User management (authorized by UserPolicy)
  resources :users, only: %i[index show create update destroy]

  # Ecommerce resources (authorized by their respective policies)
  resources :products, only: %i[index show create update destroy]
  resources :customers, only: %i[index show create update destroy]
  resources :orders, only: %i[index show create update destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end
