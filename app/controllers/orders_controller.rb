class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items.all
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = @order.customer.cart_items.all
    @total_price = @order.postage + @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }.floor
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_select] == "2"
    else
      render :new
    end
  end

  def complete
  end

  def create
    @orders = Order.new(order_params)
    if @orders.save
      Customer.find(current_customer.id).cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_price, :payment_method, :postal_code, :address, :name)
  end
end
