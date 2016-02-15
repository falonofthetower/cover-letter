Rails.application.routes.draw do
  resources :projects, only: [:index, :new]
  get "ui(/:action)", controller: "ui"
end
