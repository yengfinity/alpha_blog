require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

  test "get new user sign up form" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "user1", email: "user1@email.com", password: "password", admin: false }
    end
    @user = User.where(username: "user1").first
    session[:user_id] = @user.id
    assert_template 'users/show'
    assert_match 'user1', response.body
  end

  test "invalid user sign up" do
    @user = User.where(username: "user1").first
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: { username: " " }
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end