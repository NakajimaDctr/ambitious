Rails.application.routes.draw do
  devise_for :users
  
  root to: "movies#index"
  
  namespace :movies do
    resources :searches, only: :index
  end
  resources :movies, only: [:new, :edit, :update, :create, :destroy, :show ]
  
  resources :users, only: [:edit, :update]
end
