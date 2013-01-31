require_relative '../../../test_helper'

class Spree::Admin::OrdersControllerTest < ActionController::TestCase

  setup do
    @user = Factory.create(:admin_user)
    sign_in @user
    ActionMailer::Base.deliveries = []
  end

  context "An existing order with drop ship items" do

    setup do
      @supplier = spree_suppliers(:supplier_1)
      @supplier2 = spree_suppliers(:supplier_2)
      @order = spree_orders(:pending)
      @order.ship_address = Spree::Address.last
      @order.line_items = [ spree_line_items(:ds_li_1), spree_line_items(:ds_li_2) ]
      @order.update! && @order.next!
    end

    should "approve drop ship orders" do
      get :drop_ship_approve, :controller => 'admin/orders', :id => @order.to_param
      assert_response :redirect
      assert assigns(:order)
    end

    should "send emails to suppliers" do    
      ActionMailer::Base.deliveries = []
      assert_equal 0, ActionMailer::Base.deliveries.length
      get :drop_ship_approve, :id => @order.to_param
      tos = ActionMailer::Base.deliveries.map(&:to).flatten.uniq
      @order.drop_ship_orders.each do |dso|
        tos.include?(dso.supplier.email)
      end
    end

  end

end
