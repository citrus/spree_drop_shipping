Rails.application.routes.draw do

  namespace :admin do
    resources :suppliers do
      resources :drop_ship_orders, :as => 'orders', :path => 'orders'
    end    
    resources :drop_ship_orders
  end
  
  resources :drop_ship_orders
  
end
