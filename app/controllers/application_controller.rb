class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # replace cancan exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to take this action. Redirecting to home page."
    redirect_to home_path
  end

  private
  # authentication
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end

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
