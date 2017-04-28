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
end
