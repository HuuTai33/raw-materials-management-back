class UserCreate
  include ActiveModel::Model

  attr_accessor :email,
                :password

  validates :email, presence: true
  validates :password, presence: true

  def process!
    ActiveRecord::Base.transaction do
      User.create!(create_params)
    end
  end

  private

  def create_params
    {
      email: email,
      password: password
    }
  end
end
