Spree::Order.class_eval do

  has_many :drop_ship_orders

  # HACK! - injects `finalize_for_dropship!` into the after complete transition
  #
  # state = self.state_machine.callbacks[:after].select{|i| i.known_states[0] == "complete" }[0]
  # state.instance_variable_set("@methods", [ :finalize!, :finalize_for_dropship! ])

  def has_drop_ship_orders?
    !drop_ship_orders.empty?
  end

  def finalize_for_dropship!
    self.line_items.will_drop_ship.all.group_by{|li| li.supplier_id }.each do |supplier_id, supplier_items|
      supplier = Spree::Supplier.find(supplier_id)
      supplier.orders.create(:order => self).add(supplier_items) #.deliver!
    end
  end

  def approve_drop_ship_orders
    drop_ship_orders.select{|dso| dso.deliver }.length == drop_ship_orders.length
  end

end
