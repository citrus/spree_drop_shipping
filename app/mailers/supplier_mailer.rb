class SupplierMailer < ActionMailer::Base
  
  default_url_options[:host] = "example.com"
  
  default :from => 'no-reply@example.com'

  def welcome(supplier)
    @supplier = supplier
    @user     = supplier.user
    mail :to => @supplier.email_with_name, :subject => "#{Spree::Config[:site_name]} - Welcome!"
  end
  
end
