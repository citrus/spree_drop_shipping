class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  belongs_to :address
  has_many   :supplier_products, :dependent => :destroy
  has_many   :products, :through => :supplier_products
  has_many   :orders, :class_name => "DropShipOrder", :dependent => :nullify
  has_one    :active_drop_ship_order, :class_name => "DropShipOrder", :dependent => :nullify, :conditions => "sent_at IS NULL"
    
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :name, :phone, :presence => true
  validates :email, :presence => true, :email => true
  validates :url, :url => true

  #==========================================
  # Callbacks
  
  after_create :active_order
  before_validation :save_address, :on => :create
  
  #==========================================
  # Instance Methods
  
  # Returns the active drop ship order or creates a new one
  def active_order
    @active_order ||= self.active_drop_ship_order ? self.active_drop_ship_order : self.create_active_drop_ship_order
  end

  # Returns the supplier's email address and name in mail format
  def email_with_name
    "#{name} <#{email}>"
  end
  
  #==========================================
  # Protected Methods
    
  protected
    
    def save_address # :nodoc:
      unless address.nil?
        address.phone = phone
        address.save
        write_attribute :address_id, address.id
      end
    end
    
end
