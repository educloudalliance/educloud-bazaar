Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :cms do
        resources :materials
        resources :metadata, only: %i[index show]
      end
    end
  end
end
