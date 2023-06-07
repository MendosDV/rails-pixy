Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :profiles do
    resources :visits, only: [:create]
  end
end
