require "fileutils"
require "thor/actions"  
require "rails/generators"
require "rails/generators/rails/app/app_generator"

Rails::Generators::Base.class_eval do
  source_paths << File.expand_path('../templates', __FILE__)
end

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
  
  
  def application_definition
    @application_definition ||= begin
      contents = File.read("#{destination_path}/config/application.rb")
      contents[(contents.index("module Dummy"))..-1]
    end
  end
  alias :store_application_definition! :application_definition

  
  
  # Runs the generator
  def run!
    puts "running!"
        
    FileUtils.rm_r(destination_path) if File.directory?(destination_path)
    
    FileUtils.chdir "test" do
      Rails::Generators::AppGenerator.start([name], { :verbose => false })
    end
    
    FileUtils.chdir destination_path do
      
      puts run "ls"
      
      run "rm -r public/index.html public/images/rails.png Gemfile README doc test vendor"
            
      template "rails/boot.rb", "#{destination_path}/config/boot.rb", :force => true
      template "rails/application.rb", "#{destination_path}/config/application.rb", :force => true    
      
      run "rake spree_core:install spree_auth:install db:migrate"
      
      puts run "rails g"
      
    end
       
  end

end
