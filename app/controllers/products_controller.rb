class ProductsController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.all
    if params[:tata] == '1'
      @search_results = Product.search("tata")
    else
      @search_results = Product.search(params[:search], { filter: "price_in_cents <= #{params[:max_price].to_f * 100}"})
    end


  end

  def show
    @product = Product.find(params[:id])
  end
end
