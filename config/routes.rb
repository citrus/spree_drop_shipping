Spree::Core::Engine.routes.prepend do

  namespace :admin do

    resources :orders do
      resources :drop_ship_orders
      member do
        get :drop_ship_approve
      end
    end

    resources :suppliers do
      resources :drop_ship_orders, :as => 'orders', :path => 'orders' 
    end

    resources :drop_ship_orders do
      member do
        get :deliver
      end
    end
  end

  resources :drop_ship_orders

end
