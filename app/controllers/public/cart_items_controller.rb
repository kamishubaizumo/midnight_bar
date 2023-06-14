class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_item = current_customer.cart_items.all

    @total_price = @cart_item.inject(0) { |sum,item| sum + item.small_total_price}

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
