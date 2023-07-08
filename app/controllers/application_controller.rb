class ApplicationController < ActionController::API

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      render json: { error: 'Authentication required.' }, status: :unauthorized
    end
  end

end
