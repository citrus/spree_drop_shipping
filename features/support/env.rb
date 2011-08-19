require 'spork'

ENV["RAILS_ROOT"] = File.expand_path("../../../test/dummy", __FILE__)
 
Spork.prefork do
  require 'cucumber/rails'
  require 'capybara/cucumber'
  require 'factory_girl'
  require 'faker'
  
  I18n.reload!
  
  Capybara.default_driver   = :selenium
  Capybara.default_selector = :css
   
  include Warden::Test::Helpers    
  
  ActionController::Base.allow_rescue = false
  Cucumber::Rails::World.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation 
end
 
Spork.each_run do

  Dir["#{File.expand_path("../../../", __FILE__)}/test/support/**/*.rb"].each { |f| require f }
  
  Before do |s| 
  
    Fixtures.reset_cache
    fixtures_folder = File.expand_path("../../../test/fixtures", __FILE__)
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
    Fixtures.create_fixtures(fixtures_folder, fixtures)
    
    if s.feature.name.match(/^Admin\s/)
      @user = Factory.create(:admin_user)
      login_as @user
    end    
    
  end

end
