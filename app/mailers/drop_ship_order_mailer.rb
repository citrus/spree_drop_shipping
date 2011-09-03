class DropShipOrderMailer < ActionMailer::Base
  
  default :from => 'no-reply@example.com'

  def supplier_order(dso)
    @dso = dso
    @supplier = dso.supplier
    mail(:to => @supplier.email_with_name)
  end
  
end
