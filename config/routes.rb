Rails.application.routes.draw do

  root to: 'app#index'

  devise_scope :accountant do
    post '/accountants/sign_in', to: 'accountants/sessions#create'
    get '/accountants/sign_in', to: 'accountants/sessions#new'
    get '/accountants/sign_up', to: 'accountants/registrations#new'
    post '/accountants/', to: 'accountants/registrations#create'
  end


  devise_for :accountants
  # resources :transactions
  resources :subitems
  resources :items
  resources :accounts
  resources :accountants
  resources :debts
  resources :transfers
  resources :bank_statements, only: [:new, :create]

  resources :reports, only: [] do
    get :line, on: :collection
    get :pie_chart, on: :collection
  end

  get '/reports', to: 'reports#transfers'

  namespace :admins do
    resources :tasks
  end

end
