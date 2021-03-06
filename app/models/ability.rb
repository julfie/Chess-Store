class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    #crud functionality
    alias_action :create, :read, :update, :destroy, :to => :crud
    alias_action :create, :read, :to => :cr
  
# ADMIN ABILITIES
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      can :see_reorders
      can :admin_dash
      can :admin_nav

# MANAGER ABILITIES
    elsif user.role? :manager
      # can read anything
      can :index, :all
      can :show, :all

      # can create, edit and read employee data
      can :manage, User, :id => User.employees

      # can create, edit and read items in the system
      can :manage, Item
      can :see_reorders

      # can read full price history & create new prices
      can :cr, ItemPrice

      # can add purchases
      can :create, Purchase 

      # can read information about customers, schools and orders 
      can :read, User, :id => User.customers
      can :read, School 
      can :read, Order

      can :manager_dash
      can :manager_nav

# SHIPPER ABILITIES
    elsif user.role? :shipper
      # they can read & edit their own profile
      can :show, User, :id => user.id
      can :edit, User, :id => user.id

      # can read unshipped orders
      can :index, Order, :id => Order.not_shipped
      can :show, Order, :id => Order.not_shipped

      # can view items
      can :show, Item

      can :shipper_dash
      can :shipper_nav

# CUSOTMER ABILITIES
    elsif user.role? :customer
      # they can read & edit their own profile
      can :show, User, :id => user.id
      can :edit, User, :id => user.id
      can :delete, User, :id => user.id

      # can place orders or cancel unshipped orders
      can :create, Order
      can :destroy, Order

      #can view list of and details of active items
      can :index, Item, :active => true
      can :show, Item, :active => true

      # can see list/details of their own past orders
      can :index, Order, :user_id => user.id
      can :show, Order, :user_id => user.id

      # can add their schools
      can :create, School
      can :basic_dash
      can :basic_nav

# GUEST ABILITIES
    else
      # can view list of and details of active items
      can :index, Item, :active => true
      can :show, Item, :active => true

      # can create new user accounts and add their schools
      can :create, User
      can :create, School

      can :basic_dash
      can :basic_nav

    end
  end
end