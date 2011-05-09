# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require 'spork'

Spork.prefork do
  
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  #Bundler.require(:development, :test)
  require "rails/test_help"
  require "shoulda"
  require "factory_girl"
  require "sqlite3"
  require "faker"
  
  #require "cucumber/rails"
  require "capybara/rails"
  require "selenium/webdriver"
  
  ActionMailer::Base.delivery_method    = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options[:host] = "example.com"
  
  Rails.backtrace_cleaner.remove_silencers!
  
  Capybara.default_driver   = :selenium
  Capybara.default_selector = :css
  
  # Run any available migration if needed
  ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)
    
  # Include devise helpers for controller tests
  class ActionController::TestCase
    include Devise::TestHelpers
  end
  
  class ActiveSupport::TestCase
    self.fixture_path = File.expand_path('../fixtures', __FILE__)
    fixtures :all
  end
  
end

Spork.each_run do

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| load f }
  Dir["#{File.expand_path("../../", __FILE__)}/app/**/*.rb"].each { |f| load f }
  
  include HelperMethods

end
