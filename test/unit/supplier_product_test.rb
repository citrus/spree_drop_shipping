require_relative '../test_helper'

class SupplierProductTest < ActiveSupport::TestCase

  def setup
  
  end
  
  should validate_presence_of(:supplier_id)
  should validate_presence_of(:product_id)
  
  should belong_to(:supplier)
  should belong_to(:product)
    
  should "have a supplier model" do
    assert defined?(SupplierProduct)
  end
  
end