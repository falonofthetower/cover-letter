Rails.application.routes.draw do
  resources :projects, only: [:index]
  get "ui(/:action)", controller: "ui"
  resources :sessions, only: [:new, :create]
  get 'sign_out', to: "sessions#destroy"

  root to: "projects#index"

  namespace :admin do
    resources :projects, only: [:new, :create, :edit, :update, :destroy]
  end
end
