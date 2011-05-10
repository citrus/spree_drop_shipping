Given /^supplier named "([^"]*)" is linked to the first product$/ do |name|
  supplier = Supplier.find_by_name(name)
  product  = Product.first
  SupplierProduct.create(:supplier => supplier, :product => product)  
end
