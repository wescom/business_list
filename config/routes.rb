Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, :only => [:index, :show, :destroy] do
    put 'set_role'
    put 'password_reset_instructions'
  end
  
  get 'home/index'
  get 'welcome', :controller => 'home', :action => :welcome
  get 'business/index'

  resources :default_settings, :only => [:index, :edit, :update]
  resources :default_settings_emails
  
  resources :businesses do
    resources :create, controller: 'businesses/create', :only => [:show, :create, :update]
    collection do
      get 'business_listing_map'
      get 'business_listing'
      get 'maps'
      get 'get_map_markers'
    end
    put 'approve_business'
    put 'pause_business'
  end
  match "/create_business_wizard" => "businesses#create_business_wizard", :via => [:get]

  resources :business_types do
    get 'business_subtype_options', :on => :collection
  end
  resources :business_subtypes, :only => [:new, :create, :edit, :update, :destroy]
  resources :service_types
  resources :zones do
    get 'zone_region_options', :on => :collection
  end
  resources :regions
  resources :contacts, :only => [:new, :create, :edit, :update, :destroy]
  resources :awards, :only => [:new, :create, :edit, :update, :destroy]

  root 'home#index'
  #root 'businesses#index'
end
