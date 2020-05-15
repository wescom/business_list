Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #get 'home/index'
  get 'business/index'
  
  resources :businesses do
    collection do
      get 'business_listing'
      get 'restaurant_listing'
    end
  end
  resources :business_types
  resources :business_subtypes, :only => [:new, :create, :edit, :update, :destroy]
  resources :service_types
  resources :contacts, :only => [:new, :create, :edit, :update, :destroy]

  #root 'home#index'
  root 'businesses#index'
end
