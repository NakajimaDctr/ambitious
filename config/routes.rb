Rails.application.routes.draw do
  root to: "movies#index"

  resources :movies, only: [:show, :new, :create, :destroy]
end
