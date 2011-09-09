class CreateSuppliers < ActiveRecord::Migration

  def self.up
    create_table :suppliers do |t|
      t.references :user
      t.references :address
      t.string     :name
      t.string     :email
      t.string     :phone
      t.string     :url
      t.string     :contact
      t.string     :contact_email      
      t.string     :contact_phone
      t.timestamps
    end
    add_index :suppliers, :user_id
    add_index :suppliers, :address_id
  end

  def self.down
    drop_table :suppliers
  end
  
end
