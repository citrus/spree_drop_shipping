class CreateSuppliers < ActiveRecord::Migration

  def self.up
    create_table :suppliers do |t|
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
  end

  def self.down
    drop_table :suppliers
  end
  
end
