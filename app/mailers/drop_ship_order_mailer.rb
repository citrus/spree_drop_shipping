class DropShipOrderMailer < ActionMailer::Base
  
  default_url_options[:host] = "http://example.com"
  
  default :from => 'no-reply@example.com'

  def supplier_order(dso)
    get_defaults(dso)
    mail(:to => @supplier.email_with_name)
  end
  
  def confirmation(dso)
    get_defaults(dso)
    mail(:to => @supplier.email_with_name)
  end
  
  def shipment(dso)
    get_defaults(dso)
    mail(:to => @supplier.email_with_name)
  end
  
  private
  
    def get_defaults(dso)
      @dso = dso
      @order = dso.order
      @supplier = dso.supplier
      @address = @order.ship_address
    end
  
end
