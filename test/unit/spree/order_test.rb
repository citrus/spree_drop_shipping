require_relative '../../test_helper'

class Spree::OrderTest < ActiveSupport::TestCase

  setup do
    Spree::DropShipOrder.destroy_all
  end

  should have_many(:drop_ship_orders)
  
  should "have respond to finalize_for_dropship!" do
    assert subject.respond_to?(:finalize_for_dropship!)
  end
  
  should "check for drop ship order" do
    assert !subject.has_drop_ship_orders?
    subject.drop_ship_orders =  [ subject.drop_ship_orders.build ]
    assert subject.has_drop_ship_orders?
  end 
  
  context "An existing order" do
  
    setup do 
      @product = spree_products(:ds_ror_bag)
      @order = spree_orders(:incomplete)
    end
    
    should "add variant and set supplier id" do
      @order.add_variant(@product.master)
      assert_not_nil @order.line_items.last.supplier_id
    end
    
  end

  context "A ready to finalize order" do
  
    setup do 
      @supplier = spree_suppliers(:supplier_1)
      @supplier2 = spree_suppliers(:supplier_2)
      @order = spree_orders(:pending)
      @order.ship_address = Spree::Address.last
      @order.line_items = [ spree_line_items(:ds_li_1), spree_line_items(:ds_li_2) ]
      @order.update!
    end
  
    should "create a drop ship order for supplier during finalize" do
      assert_equal 0, @supplier.orders.count
      @order.next!
      assert_equal 1, @supplier.orders.count
    end
    
    should "become complete by setting completed at" do
      @order.next!
      assert_not_nil @order.completed_at
    end
    
    context "that's been finalized" do
      
      setup do
        @order.next!
      end
      
      should "have orders for each supplier" do
        assert_equal 2, @order.drop_ship_orders.count
      end
      
      should "approve attached drop ship orders" do
        assert @order.approve_drop_ship_orders 
      end
      
      context "and it's drop ship orders have been approved" do
        
        setup do
          @order.approve_drop_ship_orders 
        end
        
        should "have it's orders sent" do
          @order.drop_ship_orders.each do |dso|
            assert dso.state?(:sent)
          end
        end
        
      end
      
    end
  end

end
