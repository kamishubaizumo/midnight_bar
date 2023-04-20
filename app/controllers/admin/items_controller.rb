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

  # # 商品確認画面
  # def confirm
  #   @item = Item.new(item_params)
  #   render :new if @item.invalid?
  # end
  #確認画面から戻って修正する画面
  # def edit_confirm
  #   @item = Item.find(params[:id])
  #   @item.attributes = item_params
  #   render :edit if @item.invalid?
  # end

  def create
    @item = Item.new(item_params)

    #この記述はセキュリティ上問題がある。private以下に設定してあるため必要ない。
    # @item.item_name = params[:item][:item_name]
    # @item.item_text = params[:item][:item_text]
   
    
    #ビューから取ってきたものを拾ってきている
    #split(nil)は非推奨らしいので、半角スペース
    tag_list = params[:item][:tag_name].split(" ")

    #タグを保存
    if @item.save!
      @item.save_tag(tag_list)
      redirect_to admin_items_path
    else
      redirect_to new_admin_item_path
    end
    


    #確認画面に遷移
    # if params[:back] || !@item.save
    #   render :new
    # else
    #   redirect_to admin_items_path(@item),
    #   notice: "#{@item.item_name}を販売開始しました"
    # end
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

  def search_tag
   #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
      #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    #byebug
    @items = @tag.items.where(params[:id])
  end

  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :no_tax_price, :sale_status, :stock )
    
  end

end
