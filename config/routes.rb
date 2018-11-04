Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # Routes for user's listings.
  resources :listings
  resources :listings do
    resource :reservation
  end

  resources :users, controller:'users', only: [:show, :edit, :update]
  
  get "/listings/:id/verify" => "listings#verify_listing", as: "verify_listing"
  get "/my_list" => "listings#my_list", as: "my_list"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
