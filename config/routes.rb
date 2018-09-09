Rails.application.routes.draw do
  resources :transfers
  get 'transactions/', to: 'transactions#list' #, as: :transaction
  get 'transactions/new', to: 'transactions#new'
  # resources :transactions
  resources :subitems
  resources :items
  resources :accounts
  resources :accountants
end
#