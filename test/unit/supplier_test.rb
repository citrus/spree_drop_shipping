require_relative '../test_helper'

class SupplierTest < ActiveSupport::TestCase

  def setup
    
  end
  
  should validate_presence_of(:address_id)
  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_presence_of(:phone)
  
  should belong_to(:address)
  should have_many(:supplier_products)
  should have_many(:products)
  should have_many(:drop_ship_orders)
    
  should "have a supplier model" do
    assert defined?(Supplier)
  end
  
end