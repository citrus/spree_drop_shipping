Given /^I have some products$/ do
  assert 0 < Spree::Product.count
end
