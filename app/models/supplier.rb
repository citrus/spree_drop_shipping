class Supplier < ActiveRecord::Base

  validates :name, :presence => true
  
end