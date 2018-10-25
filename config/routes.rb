Rails.application.routes.draw do

  root to: 'accountants#index'

  devise_scope :accountant do
    get '/accountants/sign_in', to: 'accountants/sessions#new'
    get '/accountants/sign_up', to: 'accountants/registrations#new'
  end


  devise_for :accountants
  resources :transfers
  get 'transactions/', to: 'transactions#list' #, as: :transaction
  get 'transactions/new', to: 'transactions#new'
  # resources :transactions
  resources :subitems
  resources :items
  resources :accounts
  resources :accountants

end
