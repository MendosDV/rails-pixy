Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :profiles, only: [:new, :create, :edit, :update, :index] do
    resources :visits, only: [:create]
  end
end
