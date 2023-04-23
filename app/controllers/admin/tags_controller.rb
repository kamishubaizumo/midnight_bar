class Admin::TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.order(tag_name: :asc)
  end

  def create
    # 半角スペースで区切る
    tags = tag_params[:tag_name].split(" ")

    # 同じ値が存在したら取得し、無ければ作成 (カラム名: ブロック変数)
    tags.each do |tag|
      Tag.find_or_create_by(tag_name: tag)
    end
    redirect_to admin_tags_path
    flash[:notice] = "タグを追加しました"
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
      flash[:notice] = "タグを更新しました"
    else
      @tag = Tag.find(params[:id])
      render "edit"
      flash[:alert] = "タグを更新できませんでした"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to admin_tags_path
      flash["notice"] = "タグを削除しました"
    else
      @tag = Tag.find(params[:id])
      flash["alert"] = "タグを削除できませんでした"
    end
    
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end


end
