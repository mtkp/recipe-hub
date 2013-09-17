require 'test_helper'

class DirectionsControllerTest < ActionController::TestCase
    setup do
    @direction = directions(:one)
    @recipe = @direction.recipe
    @user = @recipe.user
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should get new" do
    get :new, recipe_id: @recipe
    assert_response :success
  end

  test "should create direction" do
    assert_difference('Direction.count') do
      post :create, direction: { body: @direction.body }, recipe_id: @recipe
    end

    assert_redirected_to @recipe
  end

  test "should get edit" do
    get :edit, id: @direction, recipe_id: @recipe
    assert_response :success
  end

  test "should update direction" do
    patch :update, id: @direction, direction: { body: @direction.body, position: @direction.position }, recipe_id: @recipe
    assert_redirected_to @recipe
  end

  test "should destroy direction" do
    assert_difference('Direction.count', -1) do
      delete :destroy, id: @direction, recipe_id: @recipe
    end

    assert_redirected_to @recipe
  end
end
