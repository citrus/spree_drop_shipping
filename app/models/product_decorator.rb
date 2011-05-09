Product.class_eval do

  has_one :supplier_product
  has_one :supplier, :through => :supplier_products
  
end