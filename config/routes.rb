Rails.application.routes.draw do
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: "pages#home"

  resources :profiles do
    resources :visits, only: [:index, :show]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/process_dom', to: 'vulgarities#process_dom'
      resources :users, only: [:index] do
        collection do
          patch :change_category
        end
      end

    end
  end
end
