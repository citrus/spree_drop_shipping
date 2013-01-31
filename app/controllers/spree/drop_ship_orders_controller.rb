class Spree::DropShipOrdersController < Spree::BaseController

  before_filter :check_authorization

  def show
    redirect_to edit_drop_ship_order_path(@dso) unless @dso.complete?
  end

  def edit
    if @dso.sent?
      flash[:notice] = I18n.t('supplier_orders.flash.sent')
    elsif @dso.confirmed?
      if @dso.errors.empty?
        flash[:notice] = I18n.t('supplier_orders.flash.confirmed')
      end
    end
    redirect_to @dso if @dso.complete?
  end

  def update

    if @dso.sent?
      success = @dso.confirm
      url = edit_drop_ship_order_path(@dso)
    elsif @dso.confirmed?
      success = @dso.update_attributes(params[:drop_ship_order]) && @dso.ship
      url = drop_ship_order_path(@dso)
      flash[:notice] = I18n.t('supplier_orders.flash.shipped') if success
    end

    if success
      redirect_to url
    else
      flash[:error] = I18n.t("supplier_orders.flash.#{@dso.confirmed? ? 'confirmation_failure' : 'finalize_failure'}")
      render :edit
    end

  end

  private

    def get_dso    
      @dso = Spree::DropShipOrder.includes(:line_items, :order => [ :ship_address ]).find(params[:id])
      @address = @dso.order.ship_address
    end

    def check_authorization
      get_dso
      authorize!(:show, @dso)
    end

end
