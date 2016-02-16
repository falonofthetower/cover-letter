Rails.application.routes.draw do
  resources :projects, only: [:index, :new, :create, :edit, :update, :destroy]
  get "ui(/:action)", controller: "ui"
end
