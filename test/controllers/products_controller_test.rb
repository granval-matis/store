require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = Product.new(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price_in_cents: rand(100..100000),
      metadata: {
        weight: rand(1..64),
        color: Faker::Color.color_name,
        size: rand(1..128),
        material: Faker::Construction.material,
        brand: Faker::Company.name,
        origin: Faker::Address.country,
        fragrance: Faker::Food.ingredient,
        brightness: rand(16..256),
        waterproof: [true, false].sample
      }
    )
    end

    test "should filter by max_price" do
      get products_url, params: { max_price: 64 }
      assert_response :success
      assert assigns(:search_results).all? { |p| p.price_in_cents <= 6400 }
    end

  test "should filter by weight" do
    get products_url, params: { weight: 32 }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:weight] <= 32 }
  end

  test "should filter by color" do
    get products_url, params: { color: "[amaranth]" }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:color] == "amaranth" }
  end

  test "should filter by size" do
    get products_url, params: { size: 64 }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:size] <= 64 }
  end

  test "should filter by material" do
    get products_url, params: { material: "[Aluminum]" }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[material] == "Aluminum" }
  end

  test "should filter by brand" do
    get products_url, params: { brand: "[Abshire Inc]" }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:brand] == "Abshire Inc" }
  end

  test "should filter by origin" do
    get products_url, params: { origin: "[France]" }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:origin] == "France" }
  end

  test "should filter by fragrance" do
    get products_url, params: { fragrance: "[Achacha]" }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:fragrance] == "Achacha" }
  end

  test "should filter by brightness" do
    get products_url, params: { brightness: 64 }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:brightness] <= 64 }
  end

  test "should filter by waterproof" do
    get products_url, params: { waterproof: 1 }
    assert_response :success
    assert assigns(:search_results).all? { |p| p.metadata[:waterproof].nil? || p.metadata[:waterproof] == true }
  end
end
