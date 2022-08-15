Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :boats, only: [:index]

  resources :bets, only: [:index, :new, :create]
  get "bets/change", to: "bets#change"
  post "bets/modify", to: "bets#modify"

  resources :leagues, only: [:index, :new, :create, :edit, :update, :delete]
end
