Rails.application.routes.draw do
  devise_for :users
  root to: 'awards#index'
  post 'awards/confirm', to: 'awards#confirm'
  resources :awards
  resources :users do
    collection do
      get :liking
    end
  end
  namespace :my do
    get '/givers', :to => "gives#all_givers"
    get '/givings', :to => "gives#all_givings"
  end
end
