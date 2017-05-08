class CartController < ActionController::Base
  include ChessStoreHelpers::Cart

  def add
    @item = Item.find(params[:id])
    quantity = params[:quantity].to_i
    for i in 1..quantity do
      add_item_to_cart(params[:id])
    end
    flash[:notice] = "Item added to cart"
    redirect_to item_path(@item)
  end

  def remove
    remove_item_from_cart(params[:id])
    @cart = get_list_of_items_in_cart
  end

  def calculate
    calculate_cart_items_cost
  end

  def checkout
    save_each_item_in_cart(params[:id])
    clear_cart
    destroy_cart
  end

end
