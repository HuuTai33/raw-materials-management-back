class Api::V1::UsersController < ApplicationController

  def create
    user = UserCreate.new(create_params).process!
    render json: user
  end

  private

  def create_params
    {
      email: params[:email],
      password: params[:password]
    }
  end

end
