class CreateDropShipLineItems < ActiveRecord::Migration

  def self.up
    create_table :drop_ship_line_items do |t|
      t.references :drop_ship_order
      t.timestamps
    end
  end

  def self.down
    drop_table :drop_ship_line_items
  end
  
end
