Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  # Route to view all races
  get '/races', to: 'character_races#index', as: 'races'
end
