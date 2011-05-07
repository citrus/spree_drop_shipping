# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require 'spork'

Spork.prefork do
  
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require "rails/test_help"
  require "shoulda"
  require 'sqlite3'
  
  ActionMailer::Base.delivery_method    = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options[:host] = "example.com"
  
  Rails.backtrace_cleaner.remove_silencers!
  
  # Configure capybara for integration testing
  require "capybara/rails"
  require "selenium/webdriver"
  
  Capybara.default_driver = :selenium
  
  # Run any available migration
  ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)
    
end

Spork.each_run do

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  
  include HelperMethods

end
