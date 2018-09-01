Rails.application.routes.draw do
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm', to: 'awards#confirm'
  resources :awards
  resources :users do
    member do
      post :give_award
    end
  end
end
