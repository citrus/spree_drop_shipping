class Admin::DropShipOrdersController < Admin::ResourceController

  def show
    @dso = load_resource
    @supplier = @dso.supplier
    @address = @dso.order.ship_address
  end
 
  private
      
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "id.desc"
      scope = if params[:supplier_id] && @supplier = Supplier.find(params[:supplier_id])
        @supplier.orders
      else
        DropShipOrder.scoped
      end      
      @search = scope.includes(:supplier).search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
