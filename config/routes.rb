Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'home/index'
  get 'business/index'
  resources :users, :only => [:index, :show, :destroy] do
    put 'set_role'
    put 'password_reset_instructions'
  end

  resources :default_settings, :only => [:index, :edit, :update]
  
  resources :businesses do
    collection do
      get 'business_listing'
    end
  end
  resources :business_types do
    get 'business_subtype_options', :on => :collection
  end
  resources :business_subtypes, :only => [:new, :create, :edit, :update, :destroy]
  resources :service_types
  resources :contacts, :only => [:new, :create, :edit, :update, :destroy]
  resources :awards, :only => [:new, :create, :edit, :update, :destroy]

  root 'home#index'
  #root 'businesses#index'
end
