require 'test_helper'

class DirectionTest < ActiveSupport::TestCase

  test "direction attr" do
    direction = Direction.new
    assert direction.invalid?
    assert direction.errors[:body].any?
    assert direction.errors[:recipe_id].any?
  end

  test "updates 'updated_at' on the recipe it belongs to" do
    direction = directions(:one)
    recipe = direction.recipe

    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for updating directions
    # update an direction
    direction.update!(body: direction.body)

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for creating directions
    # create a new direction for list
    Direction.create!(recipe_id: recipe.id, body: "lorem")

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for destroying directions
    # destroy an existing direction from list
    direction.destroy

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at

  end


  test "direction list" do
    recipe = recipes(:new_recipe)
    dir_one = Direction.new(recipe_id: recipe.id, body: "lorem")
    dir_one.append_to_list

    assert_equal 1, dir_one.position

    dir_two = Direction.new(recipe_id: recipe.id, body: "lorem")
    dir_two.append_to_list

    # first direction should be unchanged, and second should come after
    assert_equal 1, dir_one.position
    assert_equal 2, dir_two.position

    dir_three = Direction.new(recipe_id: recipe.id, body: "lorem")
    dir_three.append_to_list

    # default scope for directions should come in order
    assert_equal [dir_one.id, dir_two.id, dir_three.id],
                 recipe.directions.ids

    # removal of direction should adjust the list
    dir_one.remove_from_list

    # first direction should now be what was the second,
    # and second should be what was the third
    assert_equal 1, dir_two.reload.position
    assert_equal 2, dir_three.reload.position

    # removal from end of list should leave remaining items unchanged
    dir_three.remove_from_list

    assert_equal 1, dir_two.reload.position
    assert_equal [dir_two.id], recipe.directions.reload.ids
  end
end
