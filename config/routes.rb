Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm/given_id=:given_id', to: 'awards#confirm', as: :awards_confirm
  post 'awards/create/given_id=:given_id', to: 'awards#create', as: :awards_create
  get '/awards/given_id=:given_id', to: 'awards#new', as: :awards_new
  resources :users do
    get :all_givers, on: :collection
    get :all_givings, on: :collection
  end
  resources :awards, :except => ['new', 'confirm', 'create']
end
