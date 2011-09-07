class Admin::DropShipOrdersController < Admin::ResourceController

  def show
    @dso = load_resource
    @supplier = @dso.supplier
    @address = @dso.order.ship_address
    render :template => "drop_ship_orders/show"
  end
 
  private
      
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "id.desc"
      @search = DropShipOrder.includes(:supplier).search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
