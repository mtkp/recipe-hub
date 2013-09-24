require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase
  setup do
    @collection = collections(:one)
    @recipe = @collection.branches[0].recipe
    @user = @recipe.user
    sign_in :user, @user
  end

  teardown do
    sign_out :user
  end

  test "should show collection" do
    get :show, id: @collection
    assert_response :success
  end

end
