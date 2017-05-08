class PurchasesController < ApplicationController
  authorize_resource
  before_action :check_login
  
  def index
    @purchases = Purchase.chronological.to_a
  end

  def new
    @purchase = Purchase.new
    @purchase.item_id = params[:item_id] unless params[:item_id].nil?
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    
    if @purchase.save
      respond_to do |format|
        format.html { redirect_to purchases_path, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}." }
        format.js
      end
    else
      render action: 'new'
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end