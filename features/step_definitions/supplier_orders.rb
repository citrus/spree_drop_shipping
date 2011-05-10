Given /^I'm placing an order for a drop shippable product$/ do

  product = Product.first
  visit(product_path(product))
  click_button("Add To Cart")
  assert has_content?(product.name)
  
  # click the checkout button
  btn = find(:xpath, '//a[@class="button checkout primary"][last()]')
  assert_equal "Checkout", btn.text
  btn.click
  
  # fill in the registration step if necessary
  if has_selector? "#guest_checkout"
    within "#guest_checkout" do
      fill_in "Email", :with => Faker::Internet.email
    end
    click_button "Continue"
  end
  
  # fill in the billing info
  within "#billing" do
    fill_in "First Name", :with => "Joe"
    fill_in "Last Name", :with => "Schmo"
    fill_in "Street Address", :with => "111 State St"
    fill_in "City", :with => "Santa Barbara"
    select("California", :from => "order_bill_address_attributes_state_id")
    fill_in "Zip", :with => "93101"
    select("United States", :from => "Country")
    fill_in "Phone", :with => Faker::PhoneNumber.phone_number
  end
  check "order_use_billing"
  click_button "Save and Continue"
  
  # select shipping method
  assert has_content?("Shipping Method")
  choose "UPS Ground"
  click_button "Save and Continue"

  # create a payment
  within "#payment-methods" do
    fill_in "card_number", :with => "4111111111111111"
    fill_in "card_code",   :with => "123"
  end
  click_button "Save and Continue"
  
  # confirm payment
  assert has_content?("Confirm")
  assert has_content?(product.name)

end

Given /^I'm on the order confirmation step$/ do
  assert_equal "/checkout/confirm", current_path
end

Then /^supplier named "([^"]*)" should have (\d+) order with (\d+) product$/ do |name, order_count, product_count|
  supplier = Supplier.find_by_name(name)
  assert_equal order_count, supplier.orders.count
  # assert_equal product_count, to do
  
end
