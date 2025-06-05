Rails.application.routes.draw do

  mount ActionCable.server => "/cable"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/notifications", to: "notifications#index"

  # Defines the root path route ("/")
  # root "posts#index"
  get "/health", to: proc { [200, { "Content-Type" => "application/json" }, ['{"status": "ok", "service": "user-backend"}']] }
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"

  resources :diary_entries, only: [:create, :index]

  resources :entries, only: [:index, :show, :create, :update, :destroy]
  resources :emotions, only: [:index, :show, :create, :update, :destroy]
end
