class Admin::DropShipOrdersController < Admin::ResourceController

  def show
    @dso = load_resource
    @supplier = @dso.supplier
    @address = @dso.order.ship_address
  end
  
  def deliver
    @dso = load_resource
    if @dso.deliver
      flash[:notice] = "Drop ship order ##{@dso.id} was successfully sent!"
    else
      flash[:error] = "Drop ship order ##{@dso.id} could not be sent."
    end
    redirect_to admin_drop_ship_order_path(@dso)
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
