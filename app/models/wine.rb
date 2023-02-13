class Wine < ApplicationRecord
  validates :name, :rating, presence: true

  monetize :price_cents
end
