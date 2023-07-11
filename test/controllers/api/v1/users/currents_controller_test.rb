require 'test_helper'

class Api::V1::Users::CurrentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(email: 'test@gmail.com', password: 'password')
  end

  test 'get raw material route exist' do
    assert_routing(
      { path: '/api/v1/users/currents', method: 'get' },
      { controller: 'api/v1/users/currents', action: 'show' }
    )
  end

  test 'return an user if authenticated' do
    sign_in(@user)
    get "/api/v1/users/currents"
    response = JSON.parse(body)

    assert_equal 200, status
    assert_equal @user.id, response["id"]
  end

  test 'return nill if not authenticated' do
    get "/api/v1/users/currents"
    response = JSON.parse(body)

    assert_equal 200, status
    assert_nil response
  end

end
