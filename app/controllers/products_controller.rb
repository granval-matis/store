class ProductsController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.all
    if params[:tata] == '1'
      @search_results = Product.search("tata")
    elsif (params[:search] == '') && (params[:max_price].to_i < 1)
      @search_results = Product.all
    elsif params[:search] == ''
      @search_results = Product.search({ filter: "price_in_cents <= #{params[:max_price].to_f * 100}"})
    elsif params[:max_price].to_i < 1
      @search_results = Product.search(params[:search])
    else
      @search_results = Product.search(params[:search], { filter: "price_in_cents <= #{params[:max_price].to_f * 100}"})
    end


  end

  def show
    @product = Product.find(params[:id])
  end
end
