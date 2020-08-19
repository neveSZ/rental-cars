Rails.application.routes.draw do
  root to: 'home#index'

  resources :car_categories
  resources :subsidiaries, only: %i[index show new create]
end
