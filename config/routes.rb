Rails.application.routes.draw do
  devise_for :accounts
  use_doorkeeper
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    namespace :v1 do
      namespace :cms do
        resources :materials, only: %i[index show create update destroy]
        resources :metadata, only: %i[index show]
        resources :products, only: %i[create update show]
        resources :validate, only: %i[index]
      end
      namespace :lms do
        resource :browse, only: :create
        resource :view, only: :create
      end
      resources :apidocs, only: %i[index show]
    end
  end

  resources :materials, only: %i[index show]
  resource :shopping_cart, only: %i[destroy show create]
  get :shopping_cart_cancel, to: 'shopping_carts#cancel'
  resource :sessions, only: %i[show]
  root 'sessions#show'
end
