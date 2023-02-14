Rails.application.routes.draw do
  # Defines the root path route ("/")
  root to: 'wines#index'
  resources :wines, only: [:show, :create]
end
