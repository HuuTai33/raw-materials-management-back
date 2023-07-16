class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :pagy_conf
  after_action :rollback_per_page_pagy

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      render json: { error: 'Authentication required.' }, status: :unauthorized
    end
  end

  def pagy_conf
    Pagy::DEFAULT[:metadata] = [:count, :page, :items, :pages, :prev, :next]
    update_per_page_pagy if update_pagy_per_page?
  end

  def update_per_page_pagy
    @init_per_page = Pagy::VARS[:items]
    Pagy::DEFAULT[:items] = params[:per_page].to_i
  end

  def rollback_per_page_pagy
    Pagy::DEFAULT[:items] = @init_per_page if update_pagy_per_page?
  end

  def update_pagy_per_page?
    params[:per_page].present? && params[:per_page].to_i > 0
  end

end
