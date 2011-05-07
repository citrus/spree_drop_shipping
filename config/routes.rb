Rails.application.routes.draw do

  namespace :admin do
    resources :suppliers
  end
  
end