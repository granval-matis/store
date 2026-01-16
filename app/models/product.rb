class Product < ApplicationRecord
  has_one_attached :featured_image
  validates :price_in_cents, presence: true
  validates :name, presence: true
  validates :description, presence: true
  has_many :comments
end
