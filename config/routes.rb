Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "sign_up", to: "user#create"
  get "sign_up", to: "user#new"

  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

  get "home", to: "home#new"
  post "home", to: "home#create"
  delete "home", to: "home#destroy"
  get "home/:id", to: "home#show"
  put "home/:id", to: "home#update"

  resources :admin do
    get '/:page', action: :index, on: :collection
  end
end
