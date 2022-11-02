Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'my'
  resources :users

  #Nested routes for bookings
  resources :bookings, except: :new do
    resources :flights
    resources :hotels
  end

  get "/my_bookings", to: "bookings#current_user_bookings"
  get "/pricing", to: "home#pricing"

  #Redirect authenticated user to dashboard otherwise homepage
  authenticated :user do
    root to: "bookings#new", as: :search
  end
  
  root "home#index"

end