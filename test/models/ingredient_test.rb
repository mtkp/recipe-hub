require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  test "ingredient attr" do
    ingredient = Ingredient.new
    assert ingredient.invalid?
    assert ingredient.errors[:food].any?
    assert ingredient.errors[:recipe_id].any?
  end

  test "updates 'updated_at' on the recipe it belongs to" do
    ingredient = ingredients(:one)
    recipe = ingredient.recipe

    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for updating ingredients
    # update an ingredient
    ingredient.update!(food: ingredient.food)

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for creating ingredients
    # create a new ingredient for list
    Ingredient.create!(recipe_id: recipe.id, food: "lorem")

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for destroying ingredients
    # destroy an existing ingredient from list
    ingredient.destroy
    
    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at

  end
end
