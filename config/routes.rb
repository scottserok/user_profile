Rails.application.routes.draw do
  resources :widgets
  resources :profiles, except: %i[index]
  devise_for :users
  root to: 'widgets#index'
end
