require "test_helper"

class UserCreateTest < ActiveSupport::TestCase

  test 'can create user' do
    params = {email: "test@mail.com", password: "password"}

    user = UserCreate.new(params).process!

    assert_equal params[:email], user.email
  end

  test 'cannot create user without email' do
    params = {password: "password"}

    user = UserCreate.new(params)
    user.validate

    assert_error_message_translated(:activemodel, user, :email, :blank)
  end

  test 'cannot create user without password' do
    params = {email: "test@mail.com"}

    user = UserCreate.new(params)
    user.validate

    assert_error_message_translated(:activemodel, user, :password, :blank)
  end

end