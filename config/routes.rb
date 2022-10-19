Rails.application.routes.draw do
  resources :hotels
  resources :flights
  resources :bookings
  
  devise_for :users
  get "home/pricing"

  #Redirect authenticated user to dashboard otherwise homepage
  authenticated :user do
    root to: "dashboard#main", as: :dashboard
  end
 
  root "home#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end