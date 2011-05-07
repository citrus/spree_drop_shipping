class CreateSupplierProducts < ActiveRecord::Migration

  def self.up
    create_table :supplier_products do |t|
      t.references :supplier
      t.references :product
    end
  end

  def self.down
    drop_table :supplier_products
  end
  
end
