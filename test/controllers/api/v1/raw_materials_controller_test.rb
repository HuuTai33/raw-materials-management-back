require 'test_helper'

class Api::V1::RawMaterialsControllerTest < ActionDispatch::IntegrationTest

  def setup
  end

  test 'get raw materials route exist' do
    assert_routing(
      { path: '/api/v1/raw_materials', method: 'get' },
      { controller: 'api/v1/raw_materials', action: 'index'}
    )
  end

  test 'get raw material route exist' do
    assert_routing(
      { path: '/api/v1/raw_materials/1', method: 'get' },
      { controller: 'api/v1/raw_materials', action: 'show', id: "1" }
    )
  end

  test 'create raw material route exist' do
    assert_routing(
      { path: '/api/v1/raw_materials', method: 'post' },
      { controller: 'api/v1/raw_materials', action: 'create'}
    )
  end

  test 'update raw material route exist' do
    assert_routing(
      { path: '/api/v1/raw_materials/1', method: 'put' },
      { controller: 'api/v1/raw_materials', action: 'update', id: "1" }
    )
  end

  test 'delete raw material route exist' do
    assert_routing(
      { path: '/api/v1/raw_materials/1', method: 'delete' },
      { controller: 'api/v1/raw_materials', action: 'destroy', id: "1" }
    )
  end

  test 'can get all raw material' do
    RawMaterial.create!({ name: 'name1', category: "category1", supplier: 'supplier1', score: 10 })
    RawMaterial.create!({ name: 'name2', category: "category2", supplier: 'supplier2', score: 20 })

    get "/api/v1/raw_materials"
    response = JSON.parse(body)

    assert_equal 200, status
    assert_equal 2, response.count
  end

  test 'can get an raw material' do
    raw_material = RawMaterial.create!({ name: 'name1', category: "category1", supplier: 'supplier1', score: 10 })

    get "/api/v1/raw_materials/#{raw_material.id}"
    response = JSON.parse(body)

    assert_equal 200, status
    assert_equal raw_material.name, response["name"]
    assert_equal raw_material.category, response["category"]
    assert_equal raw_material.supplier, response["supplier"]
    assert_equal raw_material.score, response["score"]
  end

  test 'can create an raw material' do
    params = { name: 'name', category: "category", supplier: 'supplier', score: 10 }

    post "/api/v1/raw_materials", params: params
    response = JSON.parse(body)

    assert_equal 200, status
    assert RawMaterial.find(response["id"])
    assert_equal params[:name], response["name"]
    assert_equal params[:category], response["category"]
    assert_equal params[:supplier], response["supplier"]
    assert_equal params[:score], response["score"]
  end

  test 'can update an raw material' do
    raw_material = RawMaterial.create!({ name: 'name1', category: "category1", supplier: 'supplier1', score: 10 })
    params = { name: 'update_name', category: "update_category", supplier: 'update_supplier', score: 20 }

    put "/api/v1/raw_materials/#{raw_material.id}", params: params
    response = JSON.parse(body)

    assert_equal 200, status
    assert_equal params[:name], response["name"]
    assert_equal params[:category], response["category"]
    assert_equal params[:supplier], response["supplier"]
    assert_equal params[:score], response["score"]
  end

  test 'can delete an raw material' do
    raw_material = RawMaterial.create!({ name: 'name1', category: "category1", supplier: 'supplier1', score: 10 })

    delete "/api/v1/raw_materials/#{raw_material.id}"
    response = JSON.parse(body)

    assert_equal 200, status
    assert_equal "ok", response["status"]
  end

end
