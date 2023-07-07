class RawMaterial < ApplicationRecord

  validates :name, presence: true
  validates :category, presence: true
  validates :supplier, presence: true

end