# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Role.find_or_create_by!(name: 'guest')
Role.find_or_create_by!(name: 'buyer')
Role.find_or_create_by!(name: 'seller')
Role.find_or_create_by!(name: 'admin')

NUMBER_OF_PRODUCTS = 256
MIN_PRICE = 100
MAX_PRICE = 100000
MIN_WEIGHT = 1
MAX_WEIGHT = 64
MIN_SIZE = 1
MAX_SIZE = 128
MIN_BRIGHTNESS = 16
MAX_BRIGHTNESS = 256
HIGH_PROBABILITY = 2
LOW_PROBABILITY = 4

NUMBER_OF_PRODUCTS.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    price_in_cents: rand(MIN_PRICE..MAX_PRICE),
    description: Faker::Lorem.paragraph,
    metadata: {
      weight: rand(MIN_WEIGHT..MAX_WEIGHT),
      color: rand(HIGH_PROBABILITY) == 1 ? Faker::Color.color_name : nil,
      size: rand(HIGH_PROBABILITY) == 1 ? rand(MIN_SIZE..MAX_SIZE): nil,
      material: rand(LOW_PROBABILITY) == 1 ? Faker::Construction.material : nil,
      brand: rand(LOW_PROBABILITY) == 1 ? Faker::Company.name : nil,
      origin: rand(LOW_PROBABILITY) == 1 ? Faker::Address.country : nil,
      fragrance: rand(LOW_PROBABILITY) == 1 ? Faker::Food.ingredient : nil,
      brightness: rand(LOW_PROBABILITY) == 1 ? rand(MIN_BRIGHTNESS..MAX_BRIGHTNESS) : nil,
      waterproof: rand(LOW_PROBABILITY) == 1 ? [true, false].sample : nil
    }
  )
end