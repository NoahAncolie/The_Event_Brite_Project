Rails.application.routes.draw do
  get 'static_pages/index'
  get 'static_pages/secret'
  devise_for :users
  root to: "event#index"
  resources :event do
    resources :orders, only: [:new, :create]
    resources :attendances, only: [:index]
  end
  resources :user
end
