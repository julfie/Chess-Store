class HomeController < ApplicationController
  # authorize_resource
  
  def home
    if logged_in?
      if (current_user.role? :admin) || (current_user.role? :manager)
        @items_to_reorder = Item.need_reorder.alphabetical.to_a
      end
      @recents = @current_user.orders.first.order_items
    end
    @featured = Item.all.sample(8)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end