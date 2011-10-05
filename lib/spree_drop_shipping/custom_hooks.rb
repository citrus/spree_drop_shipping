module SpreeDropShipping
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after  :account_summary,          'users/drop_ship_orders'
    
    insert_after  :admin_tabs,               'admin/shared/suppliers_tab'
    insert_after  :admin_product_form_right, 'admin/shared/product_form_right'
    
    insert_after  :admin_order_show_details, 'admin/orders/drop_ship_info'
    insert_before :admin_order_show_buttons, 'admin/orders/confirm_drop_ship_info'
    
  end
end
