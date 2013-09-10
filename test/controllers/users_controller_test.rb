require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should get show" do
    get :show, username: @user
    assert_response :success
  end

end
