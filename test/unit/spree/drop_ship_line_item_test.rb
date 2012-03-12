require_relative '../../test_helper'

class Spree::DropShipLineItemTest < ActiveSupport::TestCase

  should belong_to(:drop_ship_order)
  
  should validate_presence_of(:drop_ship_order_id)
  should validate_presence_of(:variant_id)
  should validate_presence_of(:sku)
  should validate_presence_of(:quantity)
  should validate_presence_of(:price)
  
  should "calculate subtotal when line item is blank" do
    assert_equal 0, subject.subtotal
  end
  
  context "An unsaved, valid line item" do
    
    subject {
      Spree::DropShipLineItem.new(:drop_ship_order_id => 1, :variant_id => 1, :sku => "ABC123", :quantity => 2, :price => 2.75)
    }
  
    should "calculate subtotal" do
      assert_equal 5.50, subject.subtotal
    end
    
  end
end
