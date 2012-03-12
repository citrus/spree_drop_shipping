class AddSupplierToLineItems < ActiveRecord::Migration

  def self.up
    add_column :spree_line_items, :supplier_id, :integer
  end

  def self.down
    remove_column :spree_line_items, :supplier_id
  end

end
