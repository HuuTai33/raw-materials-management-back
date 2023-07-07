require "test_helper"

class RawMaterialUpdateTest < ActiveSupport::TestCase

  test 'can update raw material' do
    raw_material = RawMaterial.create!({ name: 'name', category: "category", supplier: 'supplier', score: 10 })
    update_params = { name: 'update_name', category: "update_category", supplier: 'update_supplier', score: 20 }

    updated_raw_material = RawMaterialUpdate.new(update_params).process!(raw_material)

    assert_equal update_params[:name], updated_raw_material.name
    assert_equal update_params[:category], updated_raw_material.category
    assert_equal update_params[:supplier], updated_raw_material.supplier
    assert_equal update_params[:score], updated_raw_material.score
  end

  test 'can update raw material without score' do
    raw_material = RawMaterial.create!({ name: 'name', category: "category", supplier: 'supplier', score: 10 })
    update_params = { name: 'update_name', category: "update_category", supplier: 'update_supplier' }

    updated_raw_material = RawMaterialUpdate.new(update_params).process!(raw_material)

    assert_equal update_params[:name], updated_raw_material.name
    assert_equal update_params[:category], updated_raw_material.category
    assert_equal update_params[:supplier], updated_raw_material.supplier
    assert_equal 10, updated_raw_material.score
  end

  test 'cannot update raw material without name' do
    RawMaterial.create!({ name: 'name', category: "category", supplier: 'supplier', score: 10 })
    update_params = { category: "update_category", supplier: 'update_supplier', score: 20 }

    updated_raw_material = RawMaterialUpdate.new(update_params)
    updated_raw_material.validate

    assert_error_message_translated(:activemodel, updated_raw_material, :name, :blank)
  end

  test 'cannot update raw material without category' do
    RawMaterial.create!({ name: 'name', category: "category", supplier: 'supplier', score: 10 })
    update_params = { name: 'update_name', supplier: 'update_supplier', score: 20 }

    updated_raw_material = RawMaterialUpdate.new(update_params)
    updated_raw_material.validate

    assert_error_message_translated(:activemodel, updated_raw_material, :category, :blank)
  end

  test 'cannot update raw material without supplier' do
    RawMaterial.create!({ name: 'name', category: "category", supplier: 'supplier', score: 10 })
    update_params = { name: 'update_name', category: "update_category", score: 20 }

    updated_raw_material = RawMaterialUpdate.new(update_params)
    updated_raw_material.validate

    assert_error_message_translated(:activemodel, updated_raw_material, :supplier, :blank)
  end

end