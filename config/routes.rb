Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  resources :boats, only: [:index]
  resources :bets, only: [:index, :new, :create]
  get "bets/change", to: "bets#change"
  post "bets/modify", to: "bets#modify"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
