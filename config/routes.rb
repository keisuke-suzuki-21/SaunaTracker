Rails.application.routes.draw do
  root 'dashboard#index'

  # ログイン回り
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # QRコード
  get '/entry', to: 'pages#entry'
  get '/exit', to: 'pages#exit'

  # api
  get 'pages/current_occupancy', to: 'pages#current_occupancy'
  post '/line/callback', to: 'line_webhook#callback'

  namespace :api do
    namespace :v1 do

      resources :transactions, only: [] do
        collection do
          post :entry
          post :exit
          get :count
        end
      end

      resources :stores, only: [] do
        member do
          get :current_occupancy
        end
      end

    end
  end
end
