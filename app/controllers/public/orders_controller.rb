class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    #@order.customer_id = current_costomer.id
    @order.save
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] = "2"
      @order.postal_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
            render 'new'
    end
     @cart_items = current_customer.cart_items
     @total = 0
  end
  

  def complete
  end

  def index
  end

  def show
  end

   private
   def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_code, :total_payment, :payment_method, :status )
   end
   
end

