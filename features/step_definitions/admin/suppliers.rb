Given /^I'm on the "([^"]*)" page$/ do |path|

  path = "#{path.downcase.gsub(/\s/, '_')}_path".to_sym
  
  
  puts Factory.create(:admin_user).inspect

  
  begin 
    visit send(path)
  rescue 
    puts 
  end
end