class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    @tag_list = Tag.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  private
  
  def item_params
    
  end

end
