Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :api do
    namespace :v1 do
      namespace :cms do
        resources :materials
        resources :metadata, only: %i[index show]

        resources :apidocs, only: %i[index show]
      end
    end
  end
  resources :saml, only: :index do
    collection do
      get :sso
      post :acs
      get :metadata
      get :logout
    end
  end

  resources :materials, only: %i[index show]
  resource :shopping_cart, only: %i[destroy show create]
  root 'saml#index'
end
