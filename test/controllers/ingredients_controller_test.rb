require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  setup do
    @ingredient = ingredients(:one)
    @recipe = @ingredient.recipe
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

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post :create, ingredient: { food: @ingredient.food, magnitude: @ingredient.magnitude, units: @ingredient.units }, recipe_id: @recipe
    end

    assert_redirected_to recipe_path(@ingredient.recipe_id)
  end

  test "should get edit" do
    get :edit, id: @ingredient, recipe_id: @recipe
    assert_response :success
  end

  test "should update ingredient" do
    patch :update, id: @ingredient, ingredient: { food: @ingredient.food, magnitude: @ingredient.magnitude, units: @ingredient.units }, recipe_id: @recipe
    assert_redirected_to @recipe
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete :destroy, id: @ingredient, recipe_id: @recipe
    end

    assert_redirected_to @recipe
  end
end
