require_relative '../../test_helper'

class Spree::LineItemTest < ActiveSupport::TestCase

  should "respond to has_supplier?" do
    assert subject.respond_to?(:has_supplier?)
  end
  
  should "provide drop ship attributes" do
    hash = { :variant_id => nil, :sku => nil, :name => nil, :quantity => nil, :price => nil }
    assert_equal hash, subject.drop_ship_attributes
  end
  
end
