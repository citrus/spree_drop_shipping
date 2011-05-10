module SpreeDropShipping
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after :admin_tabs, 'admin/shared/suppliers_tab'
    insert_after :admin_product_form_right, 'admin/shared/product_form_right'

  end
end