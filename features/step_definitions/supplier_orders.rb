def visit_first_product
  @product = Spree::Product.first
  visit(spree.product_path(@product))
  click_button("Add To Cart")
  assert has_content?(@product.name)
end

def click_checkout
  # click the checkout button
  btn = find(:xpath, '//a[@class="button checkout primary"][last()]')
  assert_equal "Checkout", btn.text
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

Given /^I have a shipping method$/ do
  Factory.create(:shipping_method)
end

Given /^I have a bogus payment method$/ do
  Factory.create(:bogus_payment_method, :environment => 'cucumber')
end

Given /^supplier named "([^"]*)" has been sent a drop ship order for the first product$/ do |name|
  supplier = Spree::Supplier.find_by_name(name)
  order = Spree::Order.find_by_state('complete')
  order.ship_address = Spree::Address.find_by_firstname("Boxy")
  order.save
  dso = Factory.create(:drop_ship_order, :supplier => supplier, :order => order)
  dso.add(order.line_items).deliver!
end

Given /^the last drop ship order has been confirmed$/ do
  Spree::DropShipOrder.last.confirm!
end

Then /^I should see the confirmation flash message$/ do
  step "I should see \"#{I18n.t('supplier_orders.flash.confirmed')}\" in the flash notice"
end

Then /^supplier named "([^"]*)" should have (\d+) orders? for the first product$/ do |name, order_count|
  supplier = Spree::Supplier.find_by_name(name)
  product = Spree::Product.first
  assert_equal order_count.to_i, supplier.orders.count
  assert_equal product.sku, supplier.orders.first.line_items.first.sku
end

#Then /^"([^"]*)" should receive an order email$/ do |name|
#  supplier = Spree::Supplier.find_by_name(name)
#  flunk if ActionMailer::Base.deliveries.empty?
#  assert_equal supplier.email, ActionMailer::Base.deliveries.last.to.first
#  assert_equal "#{Spree::Config[:site_name]} - Order ##{supplier.orders.last.id}", ActionMailer::Base.deliveries.last.subject
#end

Then /^I follow "([^"]*)" from within the email body$/ do |link|
  email = ActionMailer::Base.deliveries.last
  doc = Nokogiri::HTML(email.body.to_s)
  a = doc.xpath("//a[contains(.,'#{link}')]")
  if a
    visit a.attribute("href").to_s.sub("http://example.com", "")
  else
    raise Capybara::ElementNotFound, "Could not find link with text #{link.inspect}"
  end
end

Then /^I should be editing the last drop ship order$/ do
  assert_equal spree.edit_drop_ship_order_path(Spree::DropShipOrder.last), current_path
end

Then /^I should be viewing the last drop ship order$/ do
  assert_equal spree.drop_ship_order_path(Spree::DropShipOrder.last), current_path
end


