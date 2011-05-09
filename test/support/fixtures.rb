begin
  
  FactoryGirl.define do
  
    factory :supplier do
      name "Big Store"
    end
    
    factory :user do
      email { Faker::Internet.email }
      password "spree123"
      password_confirmation "spree123"
    end
  
    factory :admin_user, :parent => :user do |u|
      u.roles { [Role.find_or_create_by_name("admin")] }
    end
  
  end
  
rescue FactoryGirl::DuplicateDefinitionError
  
  puts "wtf! factories are already defined..."
  
end