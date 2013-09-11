require 'test_helper'

class InstructionsControllerTest < ActionController::TestCase
    setup do
    @instruction = instructions(:one)
    @recipe = @instruction.recipe
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

  test "should create instruction" do
    assert_difference('Instruction.count') do
      post :create, instruction: { body: @instruction.body }, recipe_id: @recipe
    end

    assert_redirected_to @recipe
  end

  test "should get edit" do
    get :edit, id: @instruction, recipe_id: @recipe
    assert_response :success
  end

  test "should update instruction" do
    patch :update, id: @instruction, instruction: { body: @instruction.body, position: @instruction.position }, recipe_id: @recipe
    assert_redirected_to @recipe
  end

  test "should destroy instruction" do
    assert_difference('Instruction.count', -1) do
      delete :destroy, id: @instruction, recipe_id: @recipe
    end

    assert_redirected_to @recipe
  end
end
