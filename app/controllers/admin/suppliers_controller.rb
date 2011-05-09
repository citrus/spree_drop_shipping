class Admin::SuppliersController < Admin::ResourceController
  
	def index
	   #  render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr?
  end
  
  private
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "name.asc"
      @search = Supplier.search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end