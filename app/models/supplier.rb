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
  
  
  def active_order
    @active_order ||= self.active_drop_ship_order ? self.active_drop_ship_order : self.create_active_drop_ship_order
    #puts "ACTIVE:"
    #puts @active_order.inspect
    @active_order 
  end
  
  def email_with_name
    "#{name} <#{email}>"
  end
  
  
  #==========================================
  # Methods
    
  protected
    
    def save_address
      unless address.nil?
        address.phone = phone
        address.save
        write_attribute :address_id, address.id
      end
    end
    
end