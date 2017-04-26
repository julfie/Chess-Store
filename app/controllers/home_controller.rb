class HomeController < ApplicationController
  before_action :check_login
  
  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end