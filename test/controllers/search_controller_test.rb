require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:tacos)
    @user = users(:one)
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should show search" do
    get :show
    assert_response :success

    # should have no results if there are no search terms
    assert_select '#results .item', 0
  end

  test "should search with search terms" do
    get :show, search_terms: @recipe.title
    assert_response :success

    # should have a result with the title of the recipe
    assert_select '#results .item a', @recipe.title
  end
end
