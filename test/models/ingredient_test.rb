require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  test "ingredient attr" do
    ingredient = Ingredient.new
    assert ingredient.invalid?
    assert ingredient.errors[:food].any?
    assert ingredient.errors[:recipe_id].any?
  end

end
