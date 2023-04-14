class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    @tag_list = Tag.all
  end

  def new
    @item = Item.new
    @tag = Tag.new
    @tag_list = Tag.all
  end

  def create
    
  end

  def show
    @item = Item.find(params[:id])
    @item_tags = @item.tags
  end

  def edit
  end

  def update
    
  end

  def destroy

  end

  private
  
  def item_params
    
  end

end
