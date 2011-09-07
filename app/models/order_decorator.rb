Order.class_eval do

  has_one :drop_ship_order

  def finalize_with_supplier_order!
    self.line_items.will_drop_ship.all.group_by{|li| li.supplier_id }.each do |supplier_id, supplier_items|
      supplier = Supplier.find(supplier_id)
      supplier.orders.create(:order => self).add(supplier_items).deliver!
    end
  end

  alias_method_chain :finalize!, :supplier_order

end
