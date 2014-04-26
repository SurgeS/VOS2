class PricesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @price = @product.prices.create(price_params)
    redirect_to @product
  end

  private
  def price_params
    params.require(:price).permit(:price, :shop, :until)
  end
end
