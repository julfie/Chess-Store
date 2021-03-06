class DashboardController < ApplicationController
  layout 'dash'
  # authorize_resource

  def dashboard
    if logged_in?
      if (current_user.role? :customer)
        redirect_to home_path
      elsif (current_user.role? :shipper)
        @unshipped_orders = Order.not_shipped.chronological
        unless @unshipped_orders.empty? || @unshipped_orders.nil?
          @order_items = Order.not_shipped.chronological.first.order_items.unshipped
        end
      elsif (current_user.role? :manager) || (current_user.role? :admin)
        @items_to_reorder = Item.need_reorder.alphabetical.to_a
        @boards = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
        @pieces = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
        @clocks = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
        @supplies = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)
      end
      if (current_user.role? :admin)
        @profits = Order.all.inject(0) { |sum, o| sum + o.grand_total }
        @salecount = Order.all.count
        @loss = Purchase.loss.all.inject(0) { |sum, o| sum + o.item.current_price }
      end
    end
  end

  def ship
    @order_item = OrderItem.where( id: params[:id] )[0]
    @order_item.ship_item
    @unshipped_orders = Order.not_shipped.chronological
    unless @unshipped_orders.empty? || @unshipped_orders.nil?
      @order_items = Order.not_shipped.chronological.first.order_items.unshipped
    end
  end

end