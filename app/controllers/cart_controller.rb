class CartController < ActionController::Base
  include ChessStoreHelpers::Cart

  def add
    @item = Item.find(params[:id])
    add_item_to_cart(params[:id])
    redirect_to item_path(@item), notice: 'Item added to cart'
  end

  def remove
    remove_item_from_cart(params[:id])
  end

  def calculate
    calculate_cart_items_cost
  end

  def get
    get_list_of_items_in_cart
  end

  def checkout
    save_each_item_in_cart(params[:id])
    clear_cart
    destroy_cart
  end

end
