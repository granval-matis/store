require "test_helper"

class ProductTest < ActiveSupport::TestCase
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

  test "should be valid with all required attributes" do
    assert @product.valid?
  end

  test "should not be valid without name" do
    @product.name = nil
    assert_not @product.valid?
    assert_includes @product.errors.full_messages, "Name can't be blank"
  end

  test "should not be valid without description" do
    @product.description = nil
    assert_not @product.valid?
    assert_includes @product.errors.full_messages, "Description can't be blank"
  end

  test "should not be valid without price_in_cents" do
    @product.price_in_cents = nil
    assert_not @product.valid?
    assert_includes @product.errors.full_messages, "Price in cents can't be blank"
  end

  test "price_in_cents is within expected range" do
    assert @product.price_in_cents.between?(100, 100000)
  end

  test "metadata weight is within expected range" do
    if @product.metadata[:weight].present?
      assert @product.metadata[:weight].between?(1, 64)
    end
  end

  test "metadata size is within expected range when present" do
    if @product.metadata[:size].present?
      assert @product.metadata[:size].between?(1, 128)
    end
  end

  test "metadata brightness is within expected range when present" do
    if @product.metadata[:brightness].present?
      assert @product.metadata[:brightness].between?(16, 256)
    end
  end

  test "metadata waterproof is boolean when present" do
    if @product.metadata[:waterproof].present?
      assert_includes [true, false], @product.metadata[:waterproof]
    end
  end

  test "should have one attached featured_image" do
    assert_respond_to @product, :featured_image
  end
end
