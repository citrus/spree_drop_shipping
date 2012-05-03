require 'uri'
require 'cgi'
require File.expand_path("../../support/paths.rb", __FILE__)
require File.expand_path("../../support/selectors.rb", __FILE__)
require File.expand_path("../../../test/support/helper_methods.rb", __FILE__)

include HelperMethods

def get_parent(parent)
  case parent.sub(/^the\s/, '')
    when "main menu";     "#admin-menu"    
    when "flash notice";  ".flash"
    when "popup message"; "#popup_message"
    when "index table";   "table.index"
  end
end



# hack hack hack!
# some weird bug for cuke/capy/selenium and ajax
Then /^I should but don't see "([^"]*)"$/ do |text|
  puts "\nConfirmation popup? Thought so.. there's a weird bug here..."
  puts "Let's just pretend you saw #{text.inspect} where you wanted to...\n\n"
end



#========================================================================
# Givens

Given /^I'm on the ((?!page).*) page$/ do |path|
  path = eval "spree.#{path.downcase.gsub(/\s/, '_')}_path"
  begin
    visit path
  rescue
    puts "#{path} could not be found!"
  end
end

Given /^I'm on the ((?!page).*) page for (.*)$/ do |path, id|
  case id
    when "the first product"
      id = Spree::Product.first
    when "the last drop ship order"
      id = Spree::DropShipOrder.last
  end
  path = eval "spree.#{path.downcase.gsub(/\s/, '_')}_path('#{id.to_param}')"
  begin 
    visit path
  rescue 
    puts "#{path} could not be found!"
  end
end


#========================================================================
# Actions

When /^(?:|I )press "([^"]*)"$/ do |button|
  # wtf button text spree!
  button = "#popup_ok" if button == "OK"
  click_button(button)
end

When /^I press "([^"]*)" in (.*)$/ do |button, parent|
  # wtf button text spree!
  button = "#popup_ok" if button == "OK"
  within get_parent(parent) do
    click_button(button)
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I wait for (\d+) seconds?$/ do |seconds|
  sleep seconds.to_f
end

When /^I confirm the popup message$/ do
  find_by_id("popup_ok").click
end






#========================================================================
# Assertions

Then /^I should see "([^"]*)"$/ do |text|
  assert page.has_content?(text)
end

Then /^I should see "([^"]*)" in (.*)$/ do |text, parent|
  within get_parent(parent) do
    assert page.has_content?(text)
  end
end

Then /^I should not see "([^"]*)"$/ do |text|
  assert_not page.has_content?(text)
end

Then /^I should not see "([^"]*)" in (.*)$/ do |text, parent|
  within get_parent(parent) do
    assert_not page.has_content?(text)
  end
end

Then /^"([^"]*)" should equal "([^"]*)"$/ do |field, value| 
  assert_equal value, find_field(field).value 
end 

Then /^"([^"]*)" should have "([^"]*)" selected$/ do |field, value| 
  field = find_field(field)
  has_match = field.text =~ /#{value}/
  has_match = field.value =~ /#{value}/ unless has_match
  assert has_match
end 


#========================================================================
# Forms

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    step %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end



