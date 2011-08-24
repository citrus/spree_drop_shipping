class Admin::DropShipOrdersController < Admin::ResourceController

  def show
    @drop_ship_order = load_resource
    @supplier = @drop_ship_order.supplier
  end

  private
      
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "name.asc"
      @search = DropShipOrder.includes(:supplier).search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
