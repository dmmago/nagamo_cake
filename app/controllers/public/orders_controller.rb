class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = @order.order_details.new
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
      order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] = "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
            render 'new'
    end
    @cart_items= current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.shipping_cost = 800
    @totalpay = @cart_items.inject(@order.shipping_cost) { |sum, item| sum + item.subtotal}
  end


  def complete
  end

  def index
    @orders= current_customer.orders.all

  end

  def show
    if params[:id] == "comfirm"
      redirect_to new_order_path
    else
    @order = Order.find(params[:id])
  end
  end

   private
   def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status )
   end

end

