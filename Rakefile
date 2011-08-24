# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

task :default => [ :test, :cucumber ]

desc "Link suppliers to products (for debugging)"
task :setup_suppliers do

  env = File.expand_path("../test/dummy/config/environment.rb", __FILE__)
  unless File.exists?(env)
    
    puts "Please make sure test/dummy exists! Try running `bundle exec dummier`"
    
  else
    
    require env
    
    if 0 == Supplier.count  
      require "factory_girl"
      require File.expand_path("../test/support/helper_methods.rb", __FILE__)
      require File.expand_path("../test/support/factories.rb", __FILE__)
      include HelperMethods
      %w(Supplier1 Supplier2 Supplier3).each {|name| Factory.create(:supplier, :name => name, :email => "#{name}@example.com") }
    end
     
    puts "Randomly linking Products & Suppliers..."
    puts "| `*` = new link | `-` = already linked |" 
    @supplier_ids = Supplier.select('id').all.map(&:id).shuffle
    @products     = Product.all
    count         = 0
    
    @products.each do |product|
      unless product.has_supplier?
        SupplierProduct.create(:product_id => product.id, :supplier_id => @supplier_ids[rand(@supplier_ids.length)])
        count += 1 
        print "*"
      else
        print "-"
      end
    end
    puts
    
    puts "#{count} products linked."
  
  end


end
