Reporte::Application.routes.draw do
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resource :home, only: [:show]
  root to: "home#show"
  get "login" => "sessions#new", :as => "login"
  get "sign_up" => "users#new", :as => "sign_up"
  get "logout" => "sessions#destroy", :as => "logout"
end