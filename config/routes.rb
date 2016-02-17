Rails.application.routes.draw do
  resources :projects, only: [:index]
  get "ui(/:action)", controller: "ui"
  resources :sessions, only: [:new, :create]

  root to: "projects#index"

  namespace :admin do
    resources :projects, only: [:new, :create, :edit, :update, :destroy]
  end
end
