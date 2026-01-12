class Product < ApplicationRecord
  has_one_attached :featured_image
  validates :price_in_cents, presence: true
  validates :name, presence: true
  has_one_attached :description
end
