Rails.application.routes.draw do
  root "sessions#index"

  resources :sessions, only: [ :create ]

  resources :expenses

  resources :settlements,
    only: [ :create ]

  get "summary",
    to: "summary#index"
end
