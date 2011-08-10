Order.class_eval do

  alias :_finalize! :finalize!

  def finalize!
    puts "FINALIZE!"
    # add supplier_order logic here...
    _finalize!
  end

end
