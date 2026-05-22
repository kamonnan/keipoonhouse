Rails.application.routes.draw do
  get "settlements/create"
  get "expenses/new"
  get "expenses/create"
  get "expenses/index"
  get "summary/index"
  root "sessions#index"

  post "/login/:id", to: "sessions#create", as: :login
  delete "/logout", to: "sessions#destroy"

  get "/summary", to: "summary#index"

  resources :expenses, only: [ :new, :create, :index ]

  resources :settlements, only: [ :create ]

  resources :settlements, only: [ :create ]
end
