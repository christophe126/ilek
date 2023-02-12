class Wine < ApplicationRecord
  validates :name, :rating, presence: true

  monetize :price_cents
  scope :ordered, -> { order(note: :desc) }
end
