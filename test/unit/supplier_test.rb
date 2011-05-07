require_relative '../test_helper'

class SupplierTest < Test::Unit::TestCase

  def setup
    
  end
  
  should validate_presence_of(:name)
  
  should "have a supplier model" do
    assert defined?(Supplier)
  end
  
end
