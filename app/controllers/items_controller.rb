class ItemsController < ApplicationController
  # before_action :check_login
  authorize_resource
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # get info on active items for filtering...
    @items = Item.active.filter(params.slice(:for_category, :for_color, :starts_with)).alphabetical.paginate(:page => params[:page]).per_page(10)
    
    #ordering options
    case params[:ordered]
      when 'price'
        # @items = @items.includes(:item_prices).reorder(item_price.current).paginate(:page => params[:page]).per_page(10)
        # @items = @items.price_order.paginate(:page => params[:page]).per_page(10)
      when 'inventory'
        @items = @items.reorder(:inventory_level).paginate(:page => params[:page]).per_page(10)
      when 'popularity'
        @items = @items.includes(:order_item).reorder('count_all desc').count('id').paginate(:page => params[:page]).per_page(10)
      when 'name'
        @items = @items.alphabetical.paginate(:page => params[:page]).per_page(10)
    end
    # get a list of any inactive items for sidebar
    if logged_in?
      if (current_user.role? :admin) || (current_user.role? :manager)
        @inactive_items = Item.inactive.alphabetical.to_a
      end
    end
  end

  def show
    # get the price history for this item
    @price_history = @item.item_prices.chronological.to_a
    # everyone sees similar items in the sidebar
    @similar_items = Item.for_category(@item.category).active.alphabetical.first(6).to_a - [@item]
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to item_path(@item), notice: "Successfully created #{@item.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to item_path(@item), notice: "Successfully updated #{@item.name}." }
        format.js
      end
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Successfully removed #{@item.name} from the system."
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :color, :category, :weight, :inventory_level, :reorder_level, :active, :photo)
  end
  
end