Given /^I have an existing supplier named "([^"]*)"$/ do |name|
  Factory.create(:supplier, :name => name)
end
