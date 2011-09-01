require_relative '../test_helper'

class DropShipOrderTest < ActiveSupport::TestCase

  should belong_to(:supplier)
  should have_many(:line_items)

  should validate_presence_of(:supplier_id)
  

  context "A new drop ship order" do
  
    setup do
      @dso = DropShipOrder.new        
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
      @supplier = suppliers(:supplier_1)
      @dso = @supplier.active_order
    end
    
    should "add line relevant line items" do
      @line_items = [ line_items(:li_1), line_items(:ds_li_1), line_items(:ds_li_2) ]
      @dso.add(@line_items)
      assert_equal 1, @dso.line_items.count
    end
    
    should "group line items and increment quantity" do
      @line_items = [ line_items(:ds_li_1), line_items(:ds_li_1), line_items(:ds_li_1) ]
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
      @line_items = [ line_items(:ds_li_1), line_items(:ds_li_1), line_items(:ds_li_1) ]
      price = @line_items.map{|li| li.quantity * li.price }.inject(:+)
      @dso.add(@line_items)
      assert_equal price, @dso.total
    end
    
  end
  
  
  context "A drop ship order's state machine" do
    
    setup do
      ActionMailer::Base.deliveries = []
      @dso = Factory.create(:drop_ship_order)
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
      
      context "and recieved" do
      
        setup do
          @dso.recieve!
        end
        
        should "move to the 'recieved' state" do
          assert_equal "recieved", @dso.state
        end    
        
        should "set recieved at" do
          assert_not_nil @dso.recieved_at
        end
        
        context "and processed" do
        
          setup do
            @dso.process!
          end
          
          should "move to the 'complete' state" do
            assert_equal "complete", @dso.state
          end  
          
          should "set processed at" do
            assert_not_nil @dso.processed_at
          end    
        
        end  
      
      end
    
    end
    
  end
  
end
