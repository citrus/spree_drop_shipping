namespace :db do
  namespace :sample do
    desc "Create sample drop ship orders"
    task :drop_ship_orders => :environment do
    
      if Order.count == 0
        puts "Please run `rake db:sample` first to create products and orders" 
        exit
      end
      
      if Supplier.count == 0
        puts "Please run `rake db:sample:suppliers` first to create suppliers" 
        exit
      end
      
      count      = 0
      @orders    = Order.complete.includes(:line_items).all
      @suppliers = Supplier.all
      
      puts "Linking existing line items to suppliers"
      LineItem.where("supplier_id IS NULL").all.each do |li|
        li.update_attributes(:supplier_id => @suppliers.shuffle.first.id)
        print "*"
      end
      puts
      
      puts "Creating Drop Ship Orders"
      25.times{|i|
        order = @orders.shuffle.first
        dso = DropShipOrder.create(:order => order, :supplier => @suppliers.shuffle.first)
        out = if dso.add(order.line_items).deliver!
          count += 1
          "*"
        else
          "-"
        end
        print out
      }
      puts
      puts "#{count} drop ship orders created."
    end  
  end
end
