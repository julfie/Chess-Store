class CartController < ActionController::Base

  def add_to_cart
  end

  def remove_from_cart
    remove_item_from_cart(item_id)
  end

  def calculate_cart
  end

  def get_cart
    cart.get_list_of_items_in_cart
  end

end
