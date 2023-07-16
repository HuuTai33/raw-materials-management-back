class Api::V1::RawMaterialsController < ApplicationController
  # before_action :authenticate_user!

  def index
    finder = RawMaterial.all.order(created_at: :desc)
    finder = finder.where('name like ?', '%' + params[:name] + '%') unless params[:name].nil?
    pagy, raw_materials = pagy(finder, page: params[:page])
    render json: { rawmaterials: raw_materials, page: pagy_metadata(pagy) }
  end

  def show
    raw_material = RawMaterial.find(params[:id])
    render json: raw_material
  end

  def create
    raw_material = RawMaterialCreate.new(create_update_params).process!
    render json: raw_material
  end

  def update
    raw_material = RawMaterialUpdate.new(create_update_params).process!(RawMaterial.find(params[:id]))
    render json: raw_material
  end

  def destroy
    RawMaterial.find(params[:id]).destroy!
    render json: { status: :ok }
  end

  private

  def create_update_params
    {
      name: params[:name],
      category: params[:category],
      supplier: params[:supplier],
      score: params[:score]
    }
  end

end
