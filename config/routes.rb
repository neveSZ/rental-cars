Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :car_categories
  resources :subsidiaries
  resources :car_models
  resources :clients, only: %i[index new create show]
  resources :cars, only: %i[new create index]
  resources :rentals, only: %i[index new create show] do
    resources :car_rentals, only: %i[new create]
    get 'search', on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index]
    end
  end
end
