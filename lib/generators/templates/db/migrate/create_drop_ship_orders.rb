class CreateDropShipOrders < ActiveRecord::Migration

  def self.up
    create_table :drop_ship_orders do |t|
      t.references :supplier
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_products
  end
  
end
