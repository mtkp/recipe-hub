class Instruction < ActiveRecord::Base
  include Duplication, RecipeUpdater
  belongs_to :recipe

  validates :body, :recipe_id, presence: :true

  before_create :add_to_list
  before_destroy :remove_from_list
  after_save :touch_recipe!
  after_destroy :touch_recipe!

  default_scope { order("position asc") }

  def add_to_list
    # add to end of list
    self.position = Instruction.where(recipe_id: recipe_id).last.try(:position)
    increment(:position) # instruction is not yet saved
  end

  def remove_from_list
    displaced_instructions = Instruction.
      where(["recipe_id = ? and position > ?", recipe_id, position])
    if displaced_instructions.any?
      displaced_instructions.each { |i| Instruction.decrement_counter(:position, i) }
    end
  end

end
