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
      end
    end
  end

  def ship
  end

end