require_relative '../test_helper'

class SupplierTest < Test::Unit::TestCase

  def setup
    
  end
  
  should validate_presence_of(:address_id)
  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_presence_of(:phone)
  
  should have_many(:products)

  #should have_one(:address)
    
  should "have a supplier model" do
    assert defined?(Supplier)
  end
  
end