Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'my'
  resources :users

  #Nested routes for bookings
  resources :bookings, shallow: true do
    resources :flights
    resources :hotels
  end
  get "/pricing", to: "home#pricing"

  #Redirect authenticated user to dashboard otherwise homepage
  authenticated :user do
    root to: "dashboard#main", as: :dashboard
  end
  
  root "home#index"

end