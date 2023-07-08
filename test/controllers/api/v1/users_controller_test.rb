require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
  end

  test 'create user route exist' do
    assert_routing(
      { path: '/api/v1/users', method: 'post' },
      { controller: 'api/v1/users', action: 'create'}
    )
  end

  test 'can create an user' do
    params = { email: 'test@gmail.com', password: "password" }

    post "/api/v1/users", params: params
    response = JSON.parse(body)

    assert_equal 200, status
    assert User.find(response["id"])
    assert_equal params[:email], response["email"]
  end

end
