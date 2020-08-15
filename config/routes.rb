Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "rooms#index"
  post "/filter_rooms" => "rooms#filter_rooms", as: :filter_rooms
  post "/search_customer" => "bookings#search_customer", as: :search_customer
  get "/edit_customer" => "bookings#edit_customer", as: :edit_customer
  put "/update_customer" => "bookings#update_customer", as: :update_customer
  resources :bookings, only: [:new, :create, :index]
end
