class CreateDropShipOrders < ActiveRecord::Migration

  def self.up
    create_table :drop_ship_orders do |t|
      t.references :supplier
      t.float      :total
      t.datetime   :sent_at
      t.datetime   :recieved_at
      t.datetime   :processed_at
      t.string     :state, :default => "active"
      t.timestamps
    end
  end

  def self.down
    drop_table :drop_ship_orders
  end
  
end
