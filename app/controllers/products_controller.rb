class ProductsController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.all
    @search_results = Product.all

    filters = []

    if params[:max_price].to_i > 0
      filters << "price_in_cents <= #{params[:max_price].to_f * 100}"
    end

    if params[:weight].to_i > 0
      filters << "weight <= #{params[:weight]}"
    end

    if params[:search] == ""
      @search_results = Product.search(filters: filters.join(' AND '))
    else
      @search_results = Product.search(params[:search], filters: filters.join(' AND '))
    end

  end

  def show
    @product = Product.find(params[:id])
  end
end
