Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions",
        omniauth_callbacks: "api/v1/auth/omniauth_callbacks"
      }
      get '/spots/lead', to: 'spots#lead'
      resources :spots, only: %i[index show]
      resources :tags, only: %i[index]
      resources :contacts, only: %i[create]
      resources :todos, only: %i[index show create update destroy]

      post '/notifications/send_push_notification', to: 'notifications#send_push_notification'
    end
  end
  get '/omniauth/line_url', to: 'api/v1/auth/auth#line_url'
  get '/auth/line/callback', to: 'api/v1/auth/omniauth_callbacks#line'
  get '/csrf_token', to: 'api/v1/auth/auth#csrf_token'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
