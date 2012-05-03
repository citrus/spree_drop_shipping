class Spree::Admin::SuppliersController < Spree::Admin::ResourceController

  before_filter :load_data, :only => [ :new, :create, :edit, :update ]

  create.before :attach_address

  def index
    # render :template => request.xhr? ? 'admin/uploads/picker' : 'admin/uploads/index', :layout => !request.xhr?
  end

  def new
    @supplier = Spree::Supplier.new
    @supplier.address = Spree::Address.new
  end

  def attach_address
    @supplier.address = Spree::Address.new(params[:address])
  end

  private

    def load_data
      @state_options   = Spree::State.order(:name).all.map{|s| [s.name, s.id] }
      @country_options = Spree::Country.order(:name).all.map{|c| [c.name, c.id] }
    end

    def collection
      params[:q] ||= {}
      params[:q][:meta_sort] ||= "name.asc"
      @search = Spree::Supplier.search(params[:q])
      @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
