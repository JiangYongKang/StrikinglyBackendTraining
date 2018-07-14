require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'fails because no password' do
    user = User.new(email: 'vincent@email.com')
    assert_not user.save
  end

  test 'fails because passwrod to short' do
    user = User.new(email: 'vincent@email.com', password: '123')
    assert_not user.save
  end

  test 'succeeds because password is long enough' do
    user = User.new(email: 'vincent@email.com', password: '123456')
    assert user.save
  end

  test 'password_digest field should not be empty' do
    user = User.create(email: 'vincent@email.com', password: '123456')
    assert_not   user.password_digest.blank?
    assert_equal user.password_digest.length, 60
  end

  test "fails because password confirmation doesnt match" do
    user = User.new(email: 'vincent@email.com', password: '123456', password_confirmation: '654321')
    assert_not user.save
  end

  test "succeeds because password & confirmation match" do
    user = User.new(email: 'vincent@email.com', password: '123456', password_confirmation: '123456')
    assert user.save
  end
end
