class Admin::ItemsController < ApplicationController

  # def index
  #    if params[:genre_id].blank?
  #     @novels = Novel.where(novel_status: "novel_public").page(params[:page]).per(20)
  #     @genres = Genre.all
  #     @index = "Novel"
  #     if params[:sort_order].present?
  #       case params[:sort_order]
  #         when "new"
  #           @novels = Novel.latest.where(novel_status: "novel_public").page(params[:page]).per(20)
  #         when "old"
  #           @novels = Novel.old.where(novel_status: "novel_public").page(params[:page]).per(20)
  #         when "comment_count"
  #           @novels = Kaminari.paginate_array(Novel.where(novel_status: "novel_public")
  #           .includes(:reviews).sort {|a,b| b.reviews.count <=> a.reviews.count}).page(params[:page]).per(20)
  #       end
  #     end
  #    else
  #       @genre = Genre.find(params[:genre_id])
  #       @novels = @genre.novels.where(novel_status: "novel_public")
  #       @novels_all = @genre.novels.count
  #       @genres = Genre.all
  #       @index = @genre.genre
  #       if params[:sort_order].present?
  #         case params[:sort_order]
  #           when "new"
  #             @novels = @novels.latest
  #             @novels = @novels
  #           when "old"
  #             @novels = @novels.old
  #             @novels = @novels
  #           when "comment_count"
  #             @novels = @novels.includes(:reviews).sort {|a,b| b.reviews.count <=> a.reviews.count}
  #             @novels = Kaminari.paginate_array(@novels)
  #         end
  #       end
  #         @novels = @novels.page(params[:page]).per(20)
  #    end
  # end





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



    
  end

  def new
    @item = Item.new
    @tag = Tag.new
    @tag_list = Tag.order(:tag_name)
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
    @tag_list = Tag.order(tag_name: :asc)
      #検索されたタグを受け取る

      # URLをadmin/items/search_tagにするとエラーが起こる。この例外処理はどうすればいいか・・・。
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    
    @items = @tag.items.where(params[:id])
  end

  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :no_tax_price, :sale_status, :stock )
    
  end

end
