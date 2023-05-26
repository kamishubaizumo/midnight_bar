class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @tag_list = Tag.all
  end

  def show
    @customer = Customer.find(params[:id])
    @tag_list = Tag.all

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.save
  end

  # 会員の論理削除
  def withdrawal
    @customer = Customer.find(params[:id])
    
    @customer.update(is_deleted: !@customer.is_deleted)

    if @customer.is_deleted
        flash[:notice] = "退会処理を実行いたしました"
    else
        flash[:notice] = "有効にしました"
    end
      redirect_to admin_customer_path(@customer.id)    
  end

end
