Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :api do
    namespace :v1 do
      namespace :cms do
        resources :materials, only: %i[index show create update destroy]
        resources :metadata, only: %i[index show]
        resources :apidocs, only: %i[index show]
      end
      namespace :lms do
        resource :browse, only: :create
        resource :view, only: :create
      end
    end
  end

  resources :materials, only: %i[index show]
  resource :shopping_cart, only: %i[destroy show create]
  get :shopping_cart_approve, to: 'shopping_carts#approve'
  resource :sessions, only: %i[show]
  root 'sessions#show'
end
