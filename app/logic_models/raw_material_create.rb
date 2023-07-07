class RawMaterialCreate
  include ActiveModel::Model

  attr_accessor :name,
                :category,
                :supplier,
                :score

  validates :name, presence: true
  validates :category, presence: true
  validates :supplier, presence: true

  def process!
    ActiveRecord::Base.transaction do
      RawMaterial.create!(create_params)
    end
  end

  private

  def create_params
    {
      name: name,
      category: category,
      supplier: supplier,
      score: score
    }
  end
end
