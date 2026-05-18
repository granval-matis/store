class Product < ApplicationRecord
  has_one_attached :featured_image
  validates :price_in_cents, presence: true
  validates :name, presence: true
  validates :description, presence: true
  has_many :comments
  attribute :metadata, :json

  include Meilisearch::Rails

  meilisearch do
    searchable_attributes [:name, :description]
    filterable_attributes [:price_in_cents]
    sortable_attributes [:name, :description]
    ranking_rules [
                    'proximity',
                    'typo',
                    'words',
                    'attribute',
                    'sort',
                    'exactness',
                  ]

    attributes_to_highlight ['*']
    attributes_to_crop [:description]
    crop_length 16
    faceting max_values_per_facet: 2000
    pagination max_total_hits: 1000
    proximity_precision 'byWord'
  end
end
