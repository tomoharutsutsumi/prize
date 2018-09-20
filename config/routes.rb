Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm/given_id=:given_id', to: 'awards#confirm'
  get '/awards/given_id=:given_id', to: 'awards#new', as: :awards_new
  resources :users
  resources :awards, :except => ['new', 'confirm']
end
