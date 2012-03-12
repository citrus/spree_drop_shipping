require_relative '../../test_helper'

class Spree::DropShipOrderTest < ActiveSupport::TestCase

  setup do
    ActionMailer::Base.deliveries = []
  end

  should belong_to(:order)
  should belong_to(:supplier)
  should have_many(:line_items)
  should have_one(:user).through(:supplier)

  should validate_presence_of(:supplier_id)
  should validate_presence_of(:order_id)  

  context "A new drop ship order" do
  
    setup do
      @dso = Spree::DropShipOrder.new        
    end
   
    should "respond to add" do
      @dso.respond_to?(:add)
    end
   
    should "calcluate total when empty" do
      assert_equal 0.0, @dso.update_total
    end
   
  end
  
  
  context "A suppliers active drop ship order" do
    
    setup do
      @supplier = spree_suppliers(:supplier_1)
      @dso = @supplier.orders.create(:order_id => 1)
    end
    
    should "add line relevant line items" do
      @line_items = [ spree_line_items(:li_1), spree_line_items(:ds_li_1), spree_line_items(:ds_li_2) ]
      @dso.add(@line_items)
      assert_equal 1, @dso.line_items.count
    end
    
    should "group line items and increment quantity" do
      @line_items = [ spree_line_items(:ds_li_1), spree_line_items(:ds_li_1), spree_line_items(:ds_li_1) ]
      quantity = @line_items.map(&:quantity).inject(:+)
      @dso.add(@line_items)
      assert_equal quantity, @dso.line_items.last.quantity
    end
    
    should "increment quantity of items already in order" do
      @line_item = Factory.build(:line_item)
      @dso.add(@line_item)
      @dso.add(@line_item)
      count = @dso.line_items.count
      quantity = @dso.line_items.first.quantity
      assert_equal 1, count
      assert_equal 2, quantity
    end
    
    should "increment quantity of grouped items already in order" do
      @line_items = [ Factory.build(:line_item), Factory.build(:line_item) ]
      @dso.add(@line_items)
      @dso.add(@line_items)
      count = @dso.line_items.count
      quantity = @dso.line_items.first.quantity
      assert_equal 1, count
      assert_equal 4, quantity
    end
    
    should "add items and update total" do
      @line_items = [ spree_line_items(:ds_li_1), spree_line_items(:ds_li_1), spree_line_items(:ds_li_1) ]
      price = @line_items.map{|li| li.quantity * li.price }.inject(:+)
      @dso.add(@line_items)
      assert_equal price, @dso.total
    end
    
  end

  context "A drop ship order's state machine" do
    
    setup do
      ActionMailer::Base.deliveries = []
      @dso = Factory.create(:drop_ship_order)
      @dso.order.ship_address = Spree::Address.find_by_firstname("Boxy")
      @dso.save
    end
    
    should "start in the 'active' state" do
      assert_equal "active", @dso.state
    end
    
    context "when delivered" do
      
      setup do
        @dso.deliver!
      end
      
      should "move to the 'sent' state" do
        assert_equal "sent", @dso.state
      end
  
      should "set sent at" do
        assert_not_nil @dso.sent_at
      end

      should "send order to supplier" do
        assert_equal @dso.supplier.email, ActionMailer::Base.deliveries.last.to.first
        assert_equal "#{Spree::Config[:site_name]} - Order ##{@dso.id}", ActionMailer::Base.deliveries.last.subject
      end
            
      context "and confirmed" do
      
        setup do
          @dso.confirm!
        end
        
        should "move to the 'confirmed' state" do
          assert_equal "confirmed", @dso.state
        end    
        
        should "set confirmed at" do
          assert_not_nil @dso.confirmed_at
        end
        
        should "send confirmation to supplier" do
          assert_equal @dso.supplier.email, ActionMailer::Base.deliveries.last.to.first
          assert_equal "Confirmation - #{Spree::Config[:site_name]} - Order ##{@dso.id}", ActionMailer::Base.deliveries.last.subject
        end
        
        context "and shipped" do
        
          setup do
            @dso.update_attributes(
              :shipping_method => "UPS Ground",
              :confirmation_number => "935468423",
              :tracking_number => "1Z03294230492345234"
            )
            @dso.ship!
          end
          
          should "move to the 'complete' state" do
            assert_equal "complete", @dso.state
          end  
          
          should "set shipped at" do
            assert_not_nil @dso.shipped_at
          end
          
          should "send shipment email to supplier" do
            # the ship state sends two emails.. so we'll get the second to last here
            index = ActionMailer::Base.deliveries.length - 2
            assert_equal @dso.supplier.email, ActionMailer::Base.deliveries[index].to.first
            assert_equal "Shipped - #{Spree::Config[:site_name]} - Order ##{@dso.id}", ActionMailer::Base.deliveries[index].subject
          end
          
          should "send shipment email to customer" do
            assert_equal @dso.order.email, ActionMailer::Base.deliveries.last.to.first
            assert_equal "Shipped - #{Spree::Config[:site_name]} - Order ##{@dso.id}", ActionMailer::Base.deliveries.last.subject
          end
        
        end
      
      end
    
    end
    
  end
  
end
