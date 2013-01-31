require_relative '../../test_helper'

class Spree::SupplierTest < ActiveSupport::TestCase

  should validate_presence_of(:address_id)
  should validate_presence_of(:name)
  should validate_presence_of(:phone)

  should belong_to(:address)
  should have_many(:supplier_products)
  should have_many(:products)
  should have_many(:orders)

  context "A new supplier" do

    setup do
      @supplier = Spree::Supplier.new
    end

    should "require email" do
      assert !@supplier.valid?      
    end

    should "validate email" do
      %w(test something.com some.thing.com something@ another@something that@one. @one.com @one@one.com one@one@one.com another@.com").each do |email|
        @supplier.email = email
        assert !@supplier.valid?
      end
    end
    
    should "allow valid email" do
      @supplier.email = "test@example.com"
      @supplier.valid?
      assert !@supplier.errors.keys.include?(:email)
    end
    
    should "not require http:// for url, but add it automatically" do
      @supplier.url = "example.com"
      @supplier.valid?
      assert !@supplier.errors.keys.include?(:url)
      assert_equal "http://example.com", @supplier.url
    end
    
    should "allow valid url" do
      @supplier.url = "http://example.com"
      @supplier.valid?
      assert !@supplier.errors.keys.include?(:url)
    end
    
  end

  context "An unsaved, valid supplier" do
  
    setup do
      @supplier = Factory.build(:supplier)
    end
    
    should "create user upon create" do
      @supplier.save
      assert_not_nil @supplier.user
    end
    
    should "send welcome email" do
      @supplier.save
      assert_equal "#{Spree::Config[:site_name]} - Welcome!", ActionMailer::Base.deliveries.last.subject
    end
    
  end

  context "An existing supplier" do
    
    setup do 
      @supplier = Factory.create(:supplier)
    end
    
    should "return email address with name" do
      assert_equal "#{@supplier.name} <#{@supplier.email}>", @supplier.email_with_name
    end
    
  end
  
end
