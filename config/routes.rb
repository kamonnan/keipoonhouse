Rails.application.routes.draw do
  root "sessions#index"

  resources :sessions, only: [ :create ]

  resources :expenses

  get "summary",
    to: "summary#index"

  resources :settlements,
  only: [ :create ]
end
