class DropShipOrdersController < Spree::BaseController
  
  before_filter :check_authorization
  
  #before_filter :get_dso
  
  def show
    redirect_to edit_drop_ship_order_path(@dso) unless @dso.complete?
  end

  def edit
    if @dso.sent?
      flash[:notice] = "Please review and click 'Confirm Order' to continue."  
    elsif @dso.confirmed?
      if @dso.errors.empty?
        flash[:notice] = "We've been notified that you've confirmed this order. To complete the order please, upon shipping, enter the shipping information and click 'Process and finalize order'. Thank You."
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
      flash[:notice] = "Thank you for your shipment!" if success
    end
    
    if success
      redirect_to url
    else
      flash[:error] = "Order was not successfully #{@dso.confirmed? ? 'confirmed' : 'processed and finalized'}."
      render :edit
    end
    
  end
   
  private
  
    def get_dso    
      @dso = DropShipOrder.includes(:line_items, :order => [ :ship_address ]).find(params[:id])
      @address = @dso.order.ship_address
    end
  
    def check_authorization
      get_dso
      authorize!(:show, @dso)
    end
  
      
end
