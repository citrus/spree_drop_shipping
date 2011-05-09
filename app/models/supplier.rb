class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  belongs_to :address
  has_many   :supplier_products
  has_many   :products, :through => :supplier_products
  
  accepts_nested_attributes_for :address
    
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => { :with => Devise.email_regexp }
    
  
  #def initialize(params)  
  #  super params
  #  address = Address.new
  #end
    
  #def valid?(options)
  #  super(options) && address.valid?
  #end
  
end