Product.class_eval do

  has_many :supplier_products
  has_one  :supplier, :through => :supplier_products
  
end