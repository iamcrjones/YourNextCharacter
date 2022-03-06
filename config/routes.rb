Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  # Route to view all races
  # get '/races', to: 'character_races#index', as: 'races'
  # get '/races/new', to: 'character_races#new', as: 'races_new'
  # post '/races/new', to: 'character_races#create', as: 'race_create'
  resources :character_races, only:[:index, :show, :new, :create, :edit, :update, :destroy]
  resources :character_classes, only:[:index, :show, :new, :create, :edit, :update, :destroy]
end
