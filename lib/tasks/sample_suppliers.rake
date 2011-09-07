namespace :db do
  namespace :sample do
    desc "Link suppliers to products (for debugging)"
    task :suppliers => :environment do
      if 0 == Supplier.count  
        require "factory_girl"
        require File.expand_path("../../../test/support/helper_methods.rb", __FILE__)
        require File.expand_path("../../../test/support/factories.rb", __FILE__)
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
end
