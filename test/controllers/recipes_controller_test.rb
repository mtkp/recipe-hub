require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:tacos)
    @user = users(:one)
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should get index" do
    get :index, user_id: @user
    assert_response :success
    assert_not_nil assigns(:recipes)
    assert_select 'tbody tr', 4
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, recipe: { notes: @recipe.notes, title: @recipe.title }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, id: @recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe
    assert_response :success
  end

  test "should update recipe" do
    patch :update, id: @recipe, recipe: { notes: @recipe.notes, title: @recipe.title }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to user_recipes_path(@user)
  end
end
