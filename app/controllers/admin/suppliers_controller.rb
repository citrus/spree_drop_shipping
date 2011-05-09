class Admin::SuppliersController < Admin::ResourceController

  before_filter :load_data, :only => [ :new, :create, :edit, :update ]
   
  create.before :attach_address
    
	def index
	   #  render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr?
  end
  
  def new
    @supplier = Supplier.new
    @supplier.address = Address.new
  end
  
  def attach_address
    @supplier.address = Address.new(params[:address])
  end
    
    
  private
  
    def load_data
      @state_options   = State.order(:name).all.map{|s| [s.name, s.id] }
      @country_options = Country.order(:name).all.map{|c| [c.name, c.id] }
    end
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "name.asc"
      @search = Supplier.search(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end