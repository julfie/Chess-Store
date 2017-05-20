class CartController < ActionController::Base
  include ChessStoreHelpers::Cart
  include ChessStoreHelpers::Shipping

  def add
    @item = Item.find(params[:id])
    quantity = params[:quantity].to_i
    for i in 1..quantity do
      add_item_to_cart(params[:id])
    end
    flash[:notice] = "Item added to cart"
    redirect_to item_path(@item)

    @subtotal = calculate_cart_items_cost
    @shipc = calculate_cart_shipping
    @total = @subtotal + @shipc
  end

  def remove
    remove_item_from_cart(params[:id])
    @cart = get_list_of_items_in_cart
    
    @subtotal = calculate_cart_items_cost
    @shipc = calculate_cart_shipping
    @total = @subtotal + @shipc
  end

end
