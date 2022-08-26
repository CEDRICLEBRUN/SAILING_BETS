Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :boats, only: [:index] do
    resources :results, only: [:new, :create, :edit, :update, :delete]
  end

  resources :bets, only: [:index, :new, :create]
  get "bets/change", to: "bets#change"
  post "bets/modify", to: "bets#modify"

  resources :results, only: [:index]

  resources :leagues, only: [:index, :show, :new, :create, :edit, :update, :delete] do
    resources :admissions, only: [:new, :create, :delete]
  end

  get 'users/dashboard'
  patch "/admissions/:id/reject", to: "admissions#reject", as: "admission_reject"
  patch "/admissions/:id/accept", to: "admissions#accept", as: "admission_accept"
end
