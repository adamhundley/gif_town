Rails.application.routes.draw do
  namespace :admin do
    resources :gifs
  end

  resources :gifs, only: [:show, :index]
  get "/faves", to: "gifs#faves"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
end
