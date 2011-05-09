module SpreeDropShipping
  class CustomHooks < Spree::ThemeSupport::HookListener
    
    insert_after :admin_tabs, 'admin/shared/suppliers_tab'

  end
end