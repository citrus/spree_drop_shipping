Given /^I'm on the "([^"]*)" page$/ do |path|
  path = "#{path.downcase.gsub(/\s/, '_')}_path".to_sym
  begin 
    visit send(path)
  rescue 
    puts "#{path} could not be found!"
  end
end