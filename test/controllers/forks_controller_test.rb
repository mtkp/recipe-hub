require 'test_helper'

class ForksControllerTest < ActionController::TestCase
   setup do
    @fork = forks(:one)
    @recipe = @fork.source
    @user = @recipe.user
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should get index" do
    get :index, recipe_id: @recipe
    assert_response :success
    assert_select '.item-list .item', minimum: 1 
  end

end
