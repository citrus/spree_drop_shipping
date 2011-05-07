class Supplier < ActiveRecord::Base

  #==========================================
  # Associations
  
  has_one  :address
  has_many :products  
    
  #==========================================
  # Validations
  
  validates_associated :address
  validates :address_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => { :with => Devise.email_regexp }
  
end