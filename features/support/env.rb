require 'spork'

ENV["RAILS_ENV"] = "cucumber"
ENV["RAILS_ROOT"] = File.expand_path("../../../test/dummy", __FILE__)

Spork.prefork do
  require 'cucumber/rails'
  require 'factory_girl'
  require 'ffaker'

  %w(calculator_factory zone_factory shipping_method_factory payment_method_factory ).map{|f| require "spree/core/testing_support/factories/#{f}" }

  I18n.reload!

  Capybara.default_driver   = :selenium
  Capybara.default_selector = :css

  include Warden::Test::Helpers    

  ActionMailer::Base.delivery_method    = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options[:host] = "example.com"

  ActionController::Base.allow_rescue = false

  Cucumber::Rails::World.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation 

end

Spork.each_run do

  Dir["#{File.expand_path("../../../", __FILE__)}/test/support/**/*.rb"].each { |f| require f }

  Before do |s| 
    ActiveRecord::Fixtures.reset_cache
    fixtures_folder = File.expand_path("../../../test/fixtures", __FILE__)
    fixtures = Dir[File.join(fixtures_folder, '**/*.yml')].map {|f| File.basename(f, '.yml') }
    ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures.map{ |f| "spree/#{f}" })

    ActionMailer::Base.deliveries = []

    if s.feature.name.match(/^Admin\s/)
      @user = Factory.create(:admin_user)
      login_as @user
    end

  end

end
