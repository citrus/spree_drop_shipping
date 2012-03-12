Spree::User.class_eval do

  has_one :supplier

  def has_supplier?
    !supplier.nil?
  end

end
