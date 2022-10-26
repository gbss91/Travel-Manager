Rails.application.routes.draw do
  resources :hotels
  resources :flights
  resources :bookings
  devise_for :users
  resources :users, only: [:show, :index, :new]
  get "/pricing", to: "home#pricing"

  #Redirect authenticated user to dashboard otherwise homepage
  authenticated :user do
    root to: "dashboard#main", as: :dashboard
  end
  
  #Root for unauthenticated users
  root "home#index"

end