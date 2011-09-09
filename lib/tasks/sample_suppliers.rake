namespace :db do
  namespace :sample do
    desc "Link suppliers to products (for debugging)"
    task :suppliers => :environment do
      
      @usa = Country.find_by_iso("US")
      @ca  = @usa.states.find_by_abbr("CA") 
      
      if Supplier.count == 0
        puts "Creating Suppliers..."
        %w(Supplier1 Supplier2 Supplier3).each do |name|
          supplier = Supplier.new(:name => name, :email => "#{name.downcase}@example.com", :phone => "800-555-5555", :url => "http://example.com", :contact => "Somebody", :contact_phone => "555-555-5555")
          supplier.build_address(:firstname => name, :lastname => name, :address1 => "100 State St", :city => "Santa Barbara", :phone => "555-555-5555", :zipcode => "93101", :state_id => @ca.id, :country_id => @usa.id)
          print "*" if supplier.save
        end
        puts        
      end
      
      puts "Randomly linking Products & Suppliers..."
      puts "`*` = new link    `-` = already linked" 
      
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
