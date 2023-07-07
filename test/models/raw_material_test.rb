require "test_helper"

class RawMaterialTest < ActiveSupport::TestCase

  test 'can create raw material' do
    params = { name: 'name', category: "category", supplier: 'supplier', score: 10 }

    raw_material = RawMaterial.create!(params)

    assert raw_material.valid?
    assert_equal params[:name], raw_material.name
    assert_equal params[:category], raw_material.category
    assert_equal params[:supplier], raw_material.supplier
  end

  test 'can create raw material without score' do
    params = { name: 'name', category: "category", supplier: 'supplier' }

    raw_material = RawMaterial.create!(params)

    assert raw_material.valid?
    assert_equal params[:name], raw_material.name
    assert_equal params[:category], raw_material.category
    assert_equal params[:supplier], raw_material.supplier
    assert_nil raw_material.score
  end

  test 'cannot create raw material without name' do
    raw_material = RawMaterial.create()

    assert_not raw_material.valid?
    assert_error_message_translated(:activerecord, raw_material, :name, :blank)
  end

  test 'cannot create raw material without category' do
    raw_material = RawMaterial.create()

    assert_not raw_material.valid?
    assert_error_message_translated(:activerecord, raw_material, :category, :blank)
  end

  test 'cannot create raw material without supplier' do
    raw_material = RawMaterial.create()

    assert_not raw_material.valid?
    assert_error_message_translated(:activerecord, raw_material, :supplier, :blank)
  end

end
