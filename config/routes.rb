Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords]

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/login', to: 'users/sessions#create'
        delete '/logout', to: 'users/sessions#destroy'
      end
      resources :raw_materials, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
