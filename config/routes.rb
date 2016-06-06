Rails.application.routes.draw do
  root to: "dashboard#show"
  resources :users, only: [:new, :create]
  resources :links, only: [:index]
end
