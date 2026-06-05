class ProductsController < ApplicationController
  allow_unauthenticated_access

  def index
    @products = Product.all
    @search_results = Product.all

    filters = []

    if params[:max_price].to_i > 0 && not params[:max_price].blank?
      filters << "price_in_cents <= #{params[:max_price].to_f * 100}"
    end

    metadata_quantities = { weight: "weight",
                            size: "size",
                            brightness: "brightness" }

    metadata_attributes = { color: "color",
                 material: "material",
                 company: "brand",
                 country: "origin",
                 ingredient: "fragrance" }

    metadata_quantities.each do |key, value|
      if params[key].to_i > 0
        if params[:restrictive_search] == "1"
          filters << "(metadata.#{value} <= #{params[key]} AND metadata.#{value} IS NOT NULL)"
        else
          filters << "(metadata.#{value} <= #{params[key]} OR metadata.#{value} IS NULL)"
        end
      end
    end

    metadata_attributes.each do |key, value|
      if params[key].present?
        if params[:restrictive_search] == "1"
          filters << "(metadata.#{value} IN #{params[key]} AND metadata.#{value} IS NOT NULL)"
        else
          filters << "(metadata.#{value} IN #{params[key]} OR metadata.#{value} IS NULL)"
        end
      end
    end

    if params[:waterproof] == "1"
      if params[:restrictive_search] == "1"
        filters << "(metadata.waterproof = true AND metadata.waterproof IS NOT NULL)"
      else
        filters << "(metadata.waterproof = true OR metadata.waterproof IS NULL)"
      end
    end

    if params[:search].blank?
      @search_results = Product.search("*", page: params[:page] || 1,  filter: filters.join(" AND "), hits_per_page: 20 )
    else
      @search_results = Product.search(params[:search], page: params[:page] || 1,  filter: filters.join(" AND "), hits_per_page: 20 )
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
