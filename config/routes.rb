Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm', to: 'awards#confirm'
  resources :awards
  resources :users do
    get :all_givers, on: :collection
    get :all_givings, on: :collection
  end
end
