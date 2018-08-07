Rails.application.routes.draw do
  resources :transfers
  resources :transactions
  resources :subitems
  resources :items
  resources :accountants
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
