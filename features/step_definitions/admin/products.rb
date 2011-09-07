Given /^supplier named "([^"]*)" is linked to the first product$/ do |name|
  supplier = Supplier.find_by_name(name)
  product  = Product.first
  # remove any linked suppliers
  SupplierProduct.where(:product_id => product.id).destroy_all
  SupplierProduct.create(:supplier => supplier, :product => product)
end
