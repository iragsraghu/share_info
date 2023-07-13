Rails.application.routes.draw do
  resources :shares, only: [:index, :create, :update]
  post '/add/subscription', to: 'shares#create_subscription'
  match '*path', :to => 'application#routing_error', via: [:get, :post]
end
