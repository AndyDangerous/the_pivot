class OrdersController < ApplicationController
  include CurrentOrder
  include SessionsHelper
  before_action :set_order, only: [:show, :edit, :update, :destroy, :checkout]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_order

  def show
    @order = Order.find(params[:id])
  end

  def new
    ## need to put user id in here
    current_order ||= Order.new(order_params)
    raise "Boom"
    current_order.order_items.create(item_id: params[:id], order_id: current_order.id)
  end

  def destroy
    @order.destroy if @order.id == session[:order_id]
    session[:order_id] = nil
    respond_to do |format|
      format.html { redirect_to items_url,
        notice: 'Your cart is currently empty' }
        format.json { head :no_content }
    end
  end

  def checkout
    if signed_in?
      @order.update(status: 'open')

      respond_to do |format|
        format.html { redirect_to review_path }
        format.json { head :no_content }
      end
    else
      flash.notice = "You need to sign in to order delicious icecream!"
      redirect_to signin_path
    end
  end

  def review
  end

  private

  def order_params
    require(:order).permits(:status, :total, :receiving)
  end

  def invalid_order
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to items_url, notice: 'Invalid cart'
  end
end
