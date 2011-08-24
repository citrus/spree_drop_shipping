require_relative '../test_helper'

class ProductTest < ActiveSupport::TestCase
  
  should have_one(:supplier_product)
  should have_one(:supplier)
  
end