require 'test_helper'

class BranchesControllerTest < ActionController::TestCase
  setup do
    @branch = branches(:one)
    @recipe = @branch.recipe
    @collection = @branch.collection
    @user = @recipe.user
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should create branch" do
    assert_difference('Branch.count') do
      post :create, branch: { position: @branch.position }, recipe_id: @recipe
    end

    assert_redirected_to recipe_path(@recipe)
  end

  test "should update branch" do
    assert_difference('Branch.count') do
      patch :update, id: @branch, branch: { position: @branch.position }, collection_id: @collection
    end

    assert_redirected_to collection_path(@collection)
  end

end
