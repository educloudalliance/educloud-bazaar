Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :cms do
        resources :materials
      end
    end
  end
end
