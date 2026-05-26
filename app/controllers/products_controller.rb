class ProductsController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.all
    @search_results = Product.all

    filters = []

    if params[:max_price].to_i > 0 && not params[:max_price].blank?
      filters << "price_in_cents <= #{params[:max_price].to_f * 100}"
    end

    if params[:weight].to_i > 0 && not params[:weight].blank?
      filters << "(metadata.weight <= #{params[:weight]} OR metadata.weight IS NULL)"

    end

    if params[:size].to_i > 0 && not params[:size].blank?
      filters << "(metadata.size <= #{params[:size]} OR metadata.size IS NULL)"
    end

    if params[:color].present?
      filters << "(metadata.color IN #{params[:color]} OR metadata.color IS NULL)"
    end

    if params[:material].present?
      filters << "(metadata.material IN #{params[:material]} OR metadata.material IS NULL)"
    end

    if params[:company].present?
      filters << "(metadata.brand IN #{params[:company]} OR metadata.brand IS NULL)"
    end

    if params[:country].present?
      filters << "(metadata.origin IN #{params[:country]} OR metadata.origin IS NULL)"
    end

    if params[:ingredient].present?
      filters << "(metadata.fragrance IN #{params[:ingredient]} OR metadata.fragrance IS NULL)"
    end

    if params[:brightness].to_i > 0 && not params[:brightness].blank?
      filters << "(metadata.brightness <= #{params[:brightness]} OR metadata.brightness IS NULL)"
    end

    if params[:waterproof] == 1
      filters << "(metadata.waterproof == true OR metadata.waterproof IS NULL)"
    end

    if params[:search].blank?
      @search_results = Product.search("*", filter: filters.join(" AND "))
    else
      @search_results = Product.search(params[:search], filter: filters.join(" AND "))
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
