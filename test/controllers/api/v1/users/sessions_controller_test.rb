require 'test_helper'

class Api::V1::Users::SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(email: 'test@gmail.com', password: 'password')
  end

  test 'create session route exist' do
    assert_routing(
      { path: '/api/v1/login', method: 'post' },
      { controller: 'api/v1/users/sessions', action: 'create'}
    )
  end

  test 'delete session route exist' do
    assert_routing(
      { path: '/api/v1/logout', method: 'delete' },
      { controller: 'api/v1/users/sessions', action: 'destroy' }
    )
  end

  test 'can create an session' do
    params = { email: 'test@gmail.com', password: "password" }

    post "/api/v1/login", params: params

    assert_equal 200, status
  end

  test 'can delete an session' do
    sign_in(@user)
    delete "/api/v1/logout"

    assert_equal 200, status
  end

end
