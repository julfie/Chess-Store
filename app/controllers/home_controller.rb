class HomeController < ApplicationController
  # authorize_resource
  
  def home
    if logged_in?
      if (current_user.role? :admin) || (current_user.role? :manager)
        @items_to_reorder = Item.need_reorder.alphabetical.to_a
      end
      unless @current_user.orders.first.nil?
        @recents = @current_user.orders.first.order_items.limit(5)
      end
    end
    @featured = Item.all.sample(6)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end