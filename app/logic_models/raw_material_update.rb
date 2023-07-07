class RawMaterialUpdate
  include ActiveModel::Model

  attr_accessor :name,
                :category,
                :supplier,
                :score

  validates :name, presence: true
  validates :category, presence: true
  validates :supplier, presence: true

  def process!(raw_material)
    ActiveRecord::Base.transaction do
      raw_material.update!(update_params)
      raw_material
    end
  end

  private

  def update_params
    hash = {
      name: name,
      category: category,
      supplier: supplier
    }
    hash.merge!(score: score) unless score.nil?
    hash
  end

end
