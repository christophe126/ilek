class Wine < ApplicationRecord
  validates :name, :rating, presence: true

  monetize :price_cents
  max_pages 20
end
