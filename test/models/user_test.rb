require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'can create user' do
    params = {email: "test@mail.com", password: "password"}

    user = User.create(params)

    assert user.valid?
    assert_equal params[:email], user.email
  end

  test 'user\'s password is encrytped by devise' do
    params = {email: "test@mail.com", password: "password"}

    user = User.create(params)
    user.reload

    assert user.valid?
    assert_not_equal params[:password], user.encrypted_password
    assert_equal params[:password], user.password
    assert user&.valid_password?(params[:password])
  end

  test 'cannot create user without email' do
    params = {password: 'password'}

    user = User.create(params)

    assert_not user.valid?
  end

  test 'cannot create user with invalid email' do
    params = {email: "test", password: 'password'}

    user = User.create(params)

    assert_not user.valid?
  end

  test 'cannot create user without password' do
    params = {email: 'test@mail.com'}

    user = User.create(params)

    assert_not user.valid?
  end

  test 'cannot create user with too short password' do
    params = {email: "test@mail.com", password: 'pas'}

    user = User.create(params)
    assert_not user.valid?
  end

  test 'cannot create users with same email' do
    params = {email: "test@mail.fr", password: "password"}
    User.create!(params)

    user = User.create(params)

    assert_not user.valid?
  end

end
