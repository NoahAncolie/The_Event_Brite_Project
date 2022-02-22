Rails.application.routes.draw do
  get 'static_pages/index'
  get 'static_pages/secret'
  devise_for :users
  root to: "event#index"
  resources :event
  resources :user
end
