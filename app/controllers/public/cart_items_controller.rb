class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.CartItem.all

  end

  def create

  end

  def update

  end

  def destroy

  end

  def destroy_all

  end
end
