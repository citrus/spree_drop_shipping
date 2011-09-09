class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  belongs_to :user
  belongs_to :address
  has_many   :supplier_products, :dependent => :destroy
  has_many   :products, :through => :supplier_products
  has_many   :orders, :class_name => "DropShipOrder", :dependent => :nullify
  
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :name, :phone, :presence => true
  validates :email, :presence => true, :email => true
  validates :url, :url => true

  #==========================================
  # Callbacks
    
  before_validation :save_address, :on => :create
  after_create :create_user_and_send_welcome
  
  #==========================================
  # Instance Methods

  # Returns the supplier's email address and name in mail format
  def email_with_name
    "#{name} <#{email}>"
  end
  
  def url=(value)
    value = "http://#{value}" unless value =~ /https?:\/\//
    write_attribute :url, value
  end
  
  
  #==========================================
  # Protected Methods
    
  protected
    
    def create_user_and_send_welcome
      password = Digest::SHA1.hexdigest(email.to_s)[0..16]
      self.create_user(:email => email, :password => password, :password_confirmation => password)
      user.generate_reset_password_token!      
      SupplierMailer.welcome(self).deliver!
    end
    
    def save_address # :nodoc:
      unless address.nil?
        address.phone = phone
        address.save
        write_attribute :address_id, address.id
      end
    end
    
end
