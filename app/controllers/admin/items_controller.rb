class Admin::ItemsController < ApplicationController

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

  def new
    @item = Item.new
    @tag = Tag.new
    @tag_list = Tag.order(:tag_name)
  
    if params[:item] && params[:item][:stock].present?
      @item.stock = params[:item][:stock]
    elsif params[:stock_id].present?
      @item.stock = params[:stock_id]
    end
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

    # 在庫は手入力を優先して保存
    @item = Item.new(item_params)
    if params[:item][:stock].present?
      @item.stock = params[:item][:stock]
    elsif params[:item][:stock_id].present?
      @item.stock = params[:item][:stock_id]
    end

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



  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :no_tax_price, :sale_status, :stock )
    
  end

end
