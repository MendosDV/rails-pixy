Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :profiles do
    resources :visits, only: [:create]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/process_dom', to: 'vulgarities#process_dom'
      resources :users, only: [:index]
    end
  end
end
