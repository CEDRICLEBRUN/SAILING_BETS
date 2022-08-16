Rails.application.routes.draw do
  get 'admissions/new'
  get 'admissions/create'
  get 'admissions/delete'
  devise_for :users
  root to: "pages#home"

  resources :boats, only: [:index]

  resources :bets, only: [:index, :new, :create]
  get "bets/change", to: "bets#change"
  post "bets/modify", to: "bets#modify"

  resources :leagues, only: [:index, :new, :create, :edit, :update, :delete] do
    resources :admissions, only: [:new, :create, :delete]
  end
end
