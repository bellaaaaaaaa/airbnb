Rails.application.routes.draw do
  get 'braintree/new'
  get 'welcome/index'
  root 'welcome#index'
  post 'reservations/:id/braintree/checkout' => 'braintree#checkout', as: 'braintree_checkout'
  post '/search' => 'listings#search', as: 'listings_search'
  post '/searchprice' => 'listings#searchprice', as: 'listings_searchprice'
  get 'listings/num_beds/1' => 'listings#one_room', as:'listings_one_room'
  get 'listings/num_beds/2' => 'listings#two_rooms', as:'listings_two_rooms'
  get 'listings/num_beds/3' => 'listings#three_rooms', as:'listings_three_rooms'
  get 'listings/num_beds/4' => 'listings#four_rooms', as:'listings_four_rooms'
  get 'listings/num_beds/5' => 'listings#five_rooms', as:'listings_five_rooms'
 
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  
  resources :users, controller: "users", only: [:create] do
    resource :password,
    controller: "clearance/passwords",
    only: [:create, :edit, :update]
  end

  # Routes for user's listings.
  # resources :listings
  resources :listings do
    resource :reservation
  end


  resources :users, controller:'users', only: [:show, :edit, :update]

  # get "/reservations/:id/braintree/new" => "braintree#new", as: "braintree_new"
  get "/listings/:id/verify" => "listings#verify_listing", as: "verify_listing"
  get "/my_list" => "listings#my_list", as: "my_list"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
