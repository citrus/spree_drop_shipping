class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  belongs_to :address
  has_many   :supplier_products
  has_many   :products, :through => :supplier_products
  
    
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => { :with => Devise.email_regexp }
  
    
  # Creates an address if the value given is a hash
  def address=(value)
    if value.is_a? Hash
      value = Address.create(value)
    end
    write_attribute :address_id, value.id
  end
  
  # Returns an existing address or a new one
  def address
    Address.find(read_attribute :address_id) rescue Address.new
  end
  
end