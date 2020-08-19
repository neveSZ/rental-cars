Rails.application.routes.draw do
  root to: 'home#index'

  resources :car_categories, only: %i[index show new create]
  resources :subsidiaries, only: %i[index show new create]
end
