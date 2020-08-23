Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :car_categories
  resources :subsidiaries
  resources :car_models
  resources :rentals, only: %i[index new create show]
end
