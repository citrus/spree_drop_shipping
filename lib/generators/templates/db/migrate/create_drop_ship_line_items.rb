class CreateDropShipLineItems < ActiveRecord::Migration

  def self.up
    create_table :drop_ship_line_items do |t|
      t.references :drop_ship_order
      t.integer    :variant_id
      t.integer    :quantity, :default => 1
      t.decimal    :price, :precision => 8, :scale => 2, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :drop_ship_line_items
  end
  
end
