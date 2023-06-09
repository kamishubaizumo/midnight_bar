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
    elsif params[:item][:stock].present?
      @item.stock = params[:item][:stock]
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
    @tags = @item.tags
    @tag_list = Tag.order(tag_name: :asc)
  end

  def edit
    @item = Item.find(params[:id])

    # タグの編集。&は、tags.map {|tag| tag.tag_name}と同じ処理。
    tag_names = @item.tags.map(&:tag_name).join(" ")
    @tag_names = tag_names

    @tag_list = Tag.order(:tag_name)
  
    if params[:item] && params[:item][:stock].present?
      @item.stock = params[:item][:stock]
    end

  end

  def update
    @item = Item.find(params[:id])

       # 在庫は手入力を優先して保存
       @item.update(item_params)
       @item.out_of_stock
       if params[:item][:stock].present?
         @item.stock = params[:item][:stock]
       end
       tag_list = params[:item][:tag_name].split(" ")
   
       #タグを保存
       if @item.save
         @item.save_tag(tag_list)
         redirect_to admin_item_path
       else
         redirect_to edit_admin_item_path
         flash[:notice] = "更新に失敗しました"
       end
    
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path

  end



  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :no_tax_price, :sale_status, :stock )
    
  end

end
