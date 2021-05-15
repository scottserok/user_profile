Rails.application.routes.draw do
  resources :profiles
  devise_for :users
  resources :widgets
  root to: 'widgets#index'
end
