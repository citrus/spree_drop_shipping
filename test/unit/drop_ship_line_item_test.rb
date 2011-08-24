require_relative '../test_helper'

class DropShipLineItemTest < ActiveSupport::TestCase

  should belong_to(:drop_ship_order)
  
end
