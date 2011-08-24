require_relative '../test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do
    DropShipOrder.destroy_all
  end

  should "have alias chain for finalize! and supplier_order methods" do
    assert subject.respond_to?(:finalize_with_supplier_order!)
  end
  
  
  context "An existing order" do
  
    setup do 
      @product = products(:ds_ror_bag)
      @order = orders(:incomplete)
    end
    
    should "add variant and set supplier id" do
      @order.add_variant(@product.master)
      assert_not_nil @order.line_items.last.supplier_id
    end
    
  end
  
  
  context "A ready to finalize order" do
  
    setup do 
      @supplier = suppliers(:supplier_1)
      @order = orders(:pending)
      @order.line_items = [ line_items(:ds_li_1) ]
      @order.update!
    end
  
    should "add to supplier orders during finalize" do
      count = @supplier.active_order.line_items.count
      assert_equal 0, count, "Supplier should start with zero line items"
      @order.finalize!
      assert_equal 1, @supplier.active_order.line_items.count
    end
    
  end
  
  
  
end
