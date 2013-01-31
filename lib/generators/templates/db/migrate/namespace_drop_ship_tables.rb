class NamespaceDropShipTables < ActiveRecord::Migration

  def self.up
    rename_table :drop_ship_line_items, :spree_drop_ship_line_items
    rename_table :drop_ship_orders, :spree_drop_ship_orders
    rename_table :supplier_products, :spree_supplier_products
    rename_table :suppliers, :spree_suppliers
  end

  def self.down
    rename_table :spree_drop_ship_line_items, :drop_ship_line_items
    rename_table :spree_drop_ship_orders, :drop_ship_orders
    rename_table :spree_supplier_products, :supplier_products
    rename_table :spree_suppliers, :suppliers
  end

end
