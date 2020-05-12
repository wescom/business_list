Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #get 'home/index'
  get 'business/index'
  
  resources :businesses
  resources :business_types
  resources :service_types

  resources :contacts

  #root 'home#index'
  root 'businesses#index'
end
