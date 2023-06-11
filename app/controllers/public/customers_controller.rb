class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render :edit
    end
  end


  def unsubscribe
  end
  
  def withdrawal

  end


  private

  def ensuer_current_customer
    customer = Customer.find(params[:id])
    unless current_customer.id == customer.id
      redirect_to current_customer
    end
  end

   # permitに:email,:passwordは設定したらダメっぽい。更新するとログアウトする。
  def customer_params
    params.require(:customer).parmit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birth,
      :postcode,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_other,
      :tel_number
    )
  end

end
