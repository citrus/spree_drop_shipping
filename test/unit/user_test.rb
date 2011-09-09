require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase

  should have_one(:supplier)

  should "respond to has_supplier?" do
    assert subject.respond_to?(:has_supplier?)
  end
    
end
