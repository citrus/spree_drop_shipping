require_relative '../test_helper'

class SupplierTest < ActiveSupport::TestCase

  def setup
    
  end
  
  should validate_presence_of(:address_id)
  should validate_presence_of(:name)
  should validate_presence_of(:phone)
  
  should belong_to(:address)
  should have_many(:supplier_products)
  should have_many(:products)
  should have_many(:orders)
    
  should "have a supplier model" do
    assert defined?(Supplier)
  end
  
  context "A new supplier" do

    setup do
      @supplier = Supplier.new        
    end

    should "require email" do
      assert !@supplier.valid?      
    end

    should "validate email" do
      %w(test something@ another@something that@one. @one.com @one@one.com one@one@one.com another@.com").each do |email|
        @supplier.email = email
        assert !@supplier.valid?
      end
    end
    
    should "allow valid email" do
      @supplier.email = "test@example.com"
      assert !@supplier.valid?
    end
    
  end
  
end