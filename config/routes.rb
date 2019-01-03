Rails.application.routes.draw do

  root to: 'tasks#index'

  devise_scope :accountant do
    get '/accountants/sign_in', to: 'accountants/sessions#new'
    get '/accountants/sign_up', to: 'accountants/registrations#new'
    post '/accountants/', to: 'accountants/registrations#create'
  end


  devise_for :accountants
  # resources :transfers
  # resources :transactions
  resources :subitems
  resources :items
  resources :accounts
  resources :accountants
  resources :tasks

  post '/transfer/create', to: 'transfers#create'
  get '/transfers/new', to: 'transfers#new'

end
