Rails.application.routes.draw do

  root to: 'accountants#index'

  devise_scope :accountant do
    get '/accountants/sign_in', to: 'accountants/sessions#new'
    get '/accountants/sign_up', to: 'accountants/registrations#new'
  end


  devise_for :accountants
  # resources :transfers
  # resources :transactions
  resources :subitems
  resources :items
  resources :accounts
  resources :accountants

  post '/transfer/create', to: 'transfers#create'
  get '/transfers/new', to: 'transfers#new'

end
