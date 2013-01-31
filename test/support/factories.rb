begin
  
  FactoryGirl.define do
  
    factory :address, :class => Spree::Address do
      firstname "SUPPLIER"
      lastname "SUPPLIER"
      address1 "100 State St"
      city "Santa Barbara"
      phone "555-555-5555"
      zipcode "93101"
      state { Spree::State.find_by_name("California") }
      country { Spree::Country.find_by_name("United States") }
    end
    
    factory :supplier, :class => Spree::Supplier do
      name "Big Store"
      email { random_email }
      phone "800-555-5555"
      url "http://example.com"
      contact "Steve"
      contact_phone "555-555-5555"
      address { Factory.create(:address) }
    end
    
    factory :user, :class => Spree::User do
      email { random_email }
      password "spree123"
      password_confirmation "spree123"
      roles { [Spree::Role.find_or_create_by_name("user")] }
    end
    
    factory :drop_ship_order, :class => Spree::DropShipOrder do
      supplier { Factory.create(:supplier) }
      order { Spree::Order.complete.last }
      total 0
    end
    
    factory :line_item, :class => Spree::LineItem do
      variant_id { Spree::Variant.first.id }
      supplier_id { Spree::Variant.first.product.supplier.id }
      quantity 1
      price 15.99
    end
  
    factory :admin_user, :parent => :user do
      roles { [Spree::Role.find_or_create_by_name("admin")] }
    end
  
  end
  
rescue FactoryGirl::DuplicateDefinitionError
  
  puts "factories are already defined..."
  
end