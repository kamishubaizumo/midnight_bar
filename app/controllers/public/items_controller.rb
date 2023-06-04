class Public::ItemsController < ApplicationController
  def index
           #検索結果画面でもタグ一覧表示
           @tag_list = Tag.order(tag_name: :asc)
           #検索されたタグを受け取る
    
        if params[:tag_id].blank?
        @items = Item.all.order(created_at: :asc)
        @index = "商品"
        else
    
          @tag = Tag.find(params[:tag_id])
          @index = @tag.tag_name
          @items = @tag.items.order(created_at: :asc)
        end
    
        @items = @items.page(params[:page]).per(20)

  end

  def show
    @item = Item.find(params[:id])
    @tags = @item.tags
    @tag_list = Tag.order(tag_name: :asc)

  end
end
