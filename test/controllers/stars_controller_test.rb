require 'test_helper'

class StarsControllerTest < ActionController::TestCase
   setup do
    @star = stars(:one)
    @recipe = @star.recipe
    @user = @recipe.user
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should get create" do
    get :create, recipe_id: recipes(:pasta)
    assert_redirected_to recipes(:pasta)
    assert_equal flash[:notice], "Recipe starred!"
  end

  test "should get destroy" do
    assert_difference('Star.count', -1) do
      delete :destroy, recipe_id: @recipe
    end

    assert_redirected_to @recipe
    assert_equal flash[:notice], "Star removed."
  end

  test "should get index" do
    get :index, recipe_id: @recipe
    assert_response :success
  end

end
