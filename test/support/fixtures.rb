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
    u.roles { [Role.find_by_name("admin") || Role.create(:name => "admin")] }
  end

end