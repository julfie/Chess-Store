class CartController < ActionController::Base

  def new
    create_cart
  end

  def add
    add_item_to_cart(params[:id])
  end

  def remove
    remove_item_from_cart(params[:id])
  end

  def calculate
    calculate_cart_items_cost
  end

  def get
    cart.get_list_of_items_in_cart
  end

  def destroy
    clear_cart
    destroy_cart
  end

  def checkout
    save_each_item_in_cart(params[:id])
    clear_cart
    destroy_cart
  end

end
