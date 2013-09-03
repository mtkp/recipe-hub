require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  test "recipe attr" do
    recipe = Recipe.new
    assert recipe.invalid?
    assert recipe.errors[:title].any?
    assert recipe.errors[:user_id].any?
  end

end
