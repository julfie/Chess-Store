class DashboardController < ApplicationController
  layout 'dash'
  # authorize_resource

  def dashboard
    if logged_in?
      if (current_user.role? :shipper)
        @unshipped_orders = Order.not_shipped.chronological
        unless @unshipped_orders.empty? || @unshipped_orders.nil?
          @order_items = Order.not_shipped.chronological.first.order_items
        end
      elsif (current_user.role? :manager)
        @items_to_reorder = Item.need_reorder.alphabetical.to_a
        @boards = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
        @pieces = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
        @clocks = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
        @supplies = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10) 
      end
    end
  end

  def ship
    if !@order_item.shipped?
      @order_item.ship
    else
      set_shipped_on_date_nil
    end
  end

  private

  def set_shipped_on_date_nil
    @order_item.shipped_on = nil
    @order_item.save!
  end

end