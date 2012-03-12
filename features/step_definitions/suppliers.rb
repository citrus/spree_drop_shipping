Given /^I have an existing supplier named "([^"]*)"$/ do |name|
  Factory.create(:supplier, :name => name)
end

Given /^I'm logged in as "([^"]*)"$/ do |name|
  supplier = Spree::Supplier.find_by_name(name)
  login_as supplier.user
end
