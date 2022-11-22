Rails.application.routes.draw do
  devise_for :users, path_prefix: 'my'
  resources :users

  # Nested routes for bookings
  resources :bookings, except: %i[new edit] do
    resources :flights, only: [:create]
    resources :hotels, only: [:create]
    get "confirm", on: :member
    get "flights/outbound"
    get "flights/inbound"
    get "flights/outbound_results", as: :outbound_results
    get "flights/inbound_results", as: :inbound_results
    get "hotels/results"
    get "hotels/hotels"
  end

  get "/my_bookings", to: "bookings#current_user_bookings"
  get "/pricing", to: "home#pricing"
  get "/insights", to: "dashboard#insights"

  # Redirect authenticated user to dashboard otherwise homepage
  authenticated :user do
    root to: "bookings#new", as: :search
  end

  root "home#index"

end