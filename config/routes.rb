Rails.application.routes.draw do
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm', to: 'awards#confirm'
  resources :awards
end
