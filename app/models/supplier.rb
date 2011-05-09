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
  
  
  #==========================================
  # Callbacks
  
  before_validation :save_address, :on => :create
  
  
  
  
  #==========================================
  # Methods
  
  protected
  
    def save_address
      address.phone = phone
      address.save
      write_attribute :address_id, address.id
    end
    
end