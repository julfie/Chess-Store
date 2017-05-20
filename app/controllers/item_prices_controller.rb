class ItemPricesController < ApplicationController
  authorize_resource  
  before_action :check_login
  
  def index
    @active_items = Item.active.alphabetical.to_a
  end

  def new
    @item_price = ItemPrice.new
    @item_price.item_id = params[:item_id] unless params[:item_id].nil?
  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.current
    
    if @item_price.save
      respond_to do |format|
        @item = @item_price.item 
        format.html { redirect_to item_path(@item), notice: "Changed the price of #{@item.name}." }
        format.js
      end
    else
      render action: 'new'
    end
  end

  private
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end
  
end