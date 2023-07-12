Rails.application.routes.draw do
  resources :shares, only: [:index, :create, :update]
  match '*path', :to => 'application#routing_error', via: [:get, :post]
end
