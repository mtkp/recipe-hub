require 'test_helper'

class InstructionTest < ActiveSupport::TestCase

  test "instruction attr" do
    instruction = Instruction.new
    assert instruction.invalid?
    assert instruction.errors[:body].any?
    assert instruction.errors[:recipe_id].any?
  end

  test "updates 'updated_at' on the recipe it belongs to" do
    instruction = instructions(:one)
    recipe = instruction.recipe

    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for updating instructions
    # update an instruction
    instruction.update!(body: instruction.body)

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for creating instructions
    # create a new instruction for list
    Instruction.create!(recipe_id: recipe.id, body: "lorem")

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at



    # log current time
    old_time = recipe.updated_at
    # make sure everything is cool
    assert_equal old_time, recipe.updated_at

    # for destroying instructions
    # destroy an existing instruction from list
    instruction.destroy

    # recipe should now be updated as well
    refute_equal old_time, recipe.reload.updated_at

  end


  test "instruction list" do
    recipe = recipes(:new_recipe)
    instr_one = Instruction.new(recipe_id: recipe.id, body: "lorem")
    instr_one.append_to_list

    assert_equal 1, instr_one.position

    instr_two = Instruction.new(recipe_id: recipe.id, body: "lorem")
    instr_two.append_to_list

    # first instruction should be unchanged, and second should come after
    assert_equal 1, instr_one.position
    assert_equal 2, instr_two.position

    instr_three = Instruction.new(recipe_id: recipe.id, body: "lorem")
    instr_three.append_to_list

    # default scope for instructions should come in order
    assert_equal [instr_one.id, instr_two.id, instr_three.id],
                 recipe.instructions.ids

    # removal of instruction should adjust the list
    instr_one.remove_from_list

    # first instruction should now be what was the second,
    # and second should be what was the third
    assert_equal 1, instr_two.reload.position
    assert_equal 2, instr_three.reload.position

    # removal from end of list should leave remaining items unchanged
    instr_three.remove_from_list

    assert_equal 1, instr_two.reload.position
    assert_equal [instr_two.id], recipe.instructions.reload.ids
  end
end
