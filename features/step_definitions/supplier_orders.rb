def visit_first_product
  @product = Product.first
  visit(product_path(@product))
  click_button("Add To Cart")
  assert has_content?(@product.name)
end

def click_checkout
  # click the checkout button
  btn = find(:xpath, '//a[@class="button checkout primary"][last()]')
  assert_equal "checkout", btn.text
  btn.click
end

def register_as_quest
  # fill in the registration step if necessary
  if has_selector? "#guest_checkout"
    within "#guest_checkout" do
      fill_in "Email", :with => Faker::Internet.email
    end
    click_button "Continue"
  end
end

def complete_billing_form
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
end

def use_billing_for_shipping
  check "order_use_billing"
end

def select_shipping_method(method="UPS Ground")
  # select shipping method
  assert has_content?("Shipping Method")
  choose method
end

def complete_credit_card_form
  # create a payment
  within "#payment-methods" do
    fill_in "card_number", :with => "4111111111111111"
    fill_in "card_code",   :with => "123"
  end
end

def save_and_continue
  click_button "Save and Continue"
end



Given /^I'm placing an order for the first product$/ do
  visit_first_product
  click_checkout
  register_as_quest
  complete_billing_form
  use_billing_for_shipping
  save_and_continue
  select_shipping_method
  save_and_continue
  complete_credit_card_form
  save_and_continue
end

Given /^I'm on the order confirmation step$/ do
  # confirm payment
  assert has_content?("Confirm")
  assert has_content?(@product.name)
  assert_equal "/checkout/confirm", current_path
end

Then /^supplier named "([^"]*)" should have (\d+) order with (\d+) product$/ do |name, order_count, product_count|
  supplier = Supplier.find_by_name(name)
  assert_equal order_count, supplier.orders.count
  # assert_equal product_count, to do
  
end
