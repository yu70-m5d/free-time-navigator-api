Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: "auth", controllers: {
        registrations: "api/v1/auth/registrations"
      }
      get '/spots/lead', to: 'spots#lead'
      resources :spots, only: %i[index show]
      resources :tags, only: %i[index]
      resources :contacts, only: %i[create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
