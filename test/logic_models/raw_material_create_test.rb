require "test_helper"

class RawMaterialCreateTest < ActiveSupport::TestCase

  test 'can create raw material' do
    params = { name: 'name', category: "category", supplier: 'supplier', score: 10 }

    raw_material = RawMaterialCreate.new(params).process!

    assert_equal params[:name], raw_material.name
    assert_equal params[:category], raw_material.category
    assert_equal params[:supplier], raw_material.supplier
    assert_equal params[:score], raw_material.score
  end

  test 'can create raw material without score' do
    params = { name: 'name', category: "category", supplier: 'supplier' }

    raw_material = RawMaterialCreate.new(params).process!

    assert_equal params[:name], raw_material.name
    assert_equal params[:category], raw_material.category
    assert_equal params[:supplier], raw_material.supplier
    assert_nil raw_material.score
  end

  test 'cannot create raw material without name' do
    params = { category: "category", supplier: 'supplier', score: 10 }

    raw_material = RawMaterialCreate.new(params)
    raw_material.validate

    assert_error_message_translated(:activemodel, raw_material, :name, :blank)
  end

  test 'cannot create raw material without category' do
    params = { name: 'name', supplier: 'supplier', score: 10 }

    raw_material = RawMaterialCreate.new(params)
    raw_material.validate

    assert_error_message_translated(:activemodel, raw_material, :category, :blank)
  end

  test 'cannot create raw material without supplier' do
    params = { name: 'name', category: "category", score: 10 }

    raw_material = RawMaterialCreate.new(params)
    raw_material.validate

    assert_error_message_translated(:activemodel, raw_material, :supplier, :blank)
  end

end