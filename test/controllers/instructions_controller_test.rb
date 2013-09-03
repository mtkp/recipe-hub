require 'test_helper'

class InstructionsControllerTest < ActionController::TestCase
  setup do
    @instruction = instructions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instructions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instruction" do
    assert_difference('Instruction.count') do
      post :create, instruction: { body: @instruction.body, position: @instruction.position, recipe_id: @instruction.recipe_id }
    end

    assert_redirected_to instruction_path(assigns(:instruction))
  end

  test "should show instruction" do
    get :show, id: @instruction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @instruction
    assert_response :success
  end

  test "should update instruction" do
    patch :update, id: @instruction, instruction: { body: @instruction.body, position: @instruction.position, recipe_id: @instruction.recipe_id }
    assert_redirected_to instruction_path(assigns(:instruction))
  end

  test "should destroy instruction" do
    assert_difference('Instruction.count', -1) do
      delete :destroy, id: @instruction
    end

    assert_redirected_to instructions_path
  end
end
