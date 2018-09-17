Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm', to: 'awards#confirm'
  resources :users
  resources :awards
end
