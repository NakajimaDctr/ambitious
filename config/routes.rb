Rails.application.routes.draw do
  root to: "movies#index"

  resources :movies, only: [:new, :edit, :update, :create, :destroy, :show ]
end
