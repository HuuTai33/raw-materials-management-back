class Api::V1::Users::SessionsController < Devise::SessionsController
  include ActionController::Cookies

  def show
    render json: current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      sign_in(user)
      render json: { message: 'Logged in successfully.', user: user }
    else
      render json: { message: 'Invalid email or password.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: 'Logged out successfully.' }
  end

end
