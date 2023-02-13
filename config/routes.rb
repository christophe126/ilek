Rails.application.routes.draw do
  get 'wines/index'
  get 'wines/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'wines#index'
end
