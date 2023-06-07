Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :profiles, except: [:destroy] do
    resources :visits, only: [:create]
  end
end
