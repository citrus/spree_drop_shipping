Given /^supplier named "([^"]*)" is linked to the first product$/ do |name|
  supplier = Spree::Supplier.find_by_name(name)
  product  = Spree::Product.first
  # remove any linked suppliers
  Spree::SupplierProduct.where(:product_id => product.id).destroy_all
  Spree::SupplierProduct.create(:supplier => supplier, :product => product)
end
