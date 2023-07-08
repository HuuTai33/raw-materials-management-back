Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :raw_materials, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
