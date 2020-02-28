Rails.application.routes.draw do
  devise_for :users
  
  root to: "videos#index"
  
  namespace :videos do
    resources :searches, only: :index
  end
  resources :videos, only: [:new, :edit, :update, :create, :destroy, :show ]
  
  resources :users, only: [:edit, :update]
end
