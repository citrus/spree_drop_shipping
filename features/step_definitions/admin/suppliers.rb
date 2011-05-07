Given /^I go to the admin suppliers page$/ do
  #click_link("suppliers")
  visit "/admin/suppliers" #admin_suppliers_path
end

When /^I follow "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
