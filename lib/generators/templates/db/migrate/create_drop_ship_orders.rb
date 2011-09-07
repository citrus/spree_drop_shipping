class CreateDropShipOrders < ActiveRecord::Migration

  def self.up
    create_table :drop_ship_orders do |t|
      t.references :order
      t.references :supplier
      t.float      :total
      t.string     :shipping_method
      t.string     :confirmation_number
      t.string     :tracking_number
      t.text       :notes
      t.datetime   :sent_at
      t.datetime   :confirmed_at
      t.datetime   :shipped_at
      t.string     :state, :default => "active"          
      t.timestamps
    end
  end

  def self.down
    drop_table :drop_ship_orders
  end
  
end
