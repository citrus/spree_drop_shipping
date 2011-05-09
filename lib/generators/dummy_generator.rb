require "fileutils"
require "thor/actions"  
require "rails/generators"
require "rails/generators/rails/app/app_generator"

# Add to the source paths.. is there a better way to do this?!
Rails::Generators::Base.class_eval do
  source_paths << File.expand_path('../templates', __FILE__)
end


# Much of this generator came from enginex by José Valim
# https://github.com/josevalim/enginex/blob/master/lib/enginex.rb

class DummyGenerator < Rails::Generators::Base
  
  # The name of the rails application
  def name
    "dummy"
  end
  
  # The name of the extension to be tested
  def extension
    "spree_drop_shipping"
  end  
  
  # The name, camelized
  def camelized
    @camelized ||= name.camelize
  end

  # The name, underscored
  def underscored
    @underscored ||= name.underscore
  end
  
  # Path to the extension's test folder
  def test_path
    File.expand_path("../../../test", __FILE__)
  end
  
  # Path to the testing application
  def destination_path
    File.join(test_path, name)
  end
  
  # gets the current application.rb contents
  def application_definition
    @application_definition ||= begin
      contents = File.read("#{destination_path}/config/application.rb")
      contents[(contents.index("module Dummy"))..-1]
    end
  end
  alias :store_application_definition! :application_definition

  
  
  # Runs the generator
  def run!
    
    # remove existing test app 
    FileUtils.rm_r(destination_path) if File.directory?(destination_path)
    
    # cd into the test dir and run the base app generator
    FileUtils.chdir "test" do
      Rails::Generators::AppGenerator.start([name], { :verbose => false })
    end
    
    # cd into the new app and customize
    FileUtils.chdir destination_path do
      # remove unnecessary files    
      run "rm -r public/index.html public/images/rails.png Gemfile README doc test vendor"
            
      # replace crucial templates
      template "rails/boot.rb", "#{destination_path}/config/boot.rb", :force => true
      template "rails/application.rb", "#{destination_path}/config/application.rb", :force => true    
      
      # install spree and migrate db
      run "rake spree_core:install spree_auth:install spree_sample:install"
      run "rails g spree_drop_shipping:install"
      run "rake db:migrate RAILS_ENV=test"
      
      # add cucumber to database.yml
      append_file "#{destination_path}/config/database.yml" do
        %(cucumber:
          <<: *test)
      end
      
    end
       
  end

end
