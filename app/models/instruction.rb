class Instruction < ActiveRecord::Base
  belongs_to :recipe

  validates :body, :position, :recipe_id, presence: :true
  after_save :touch_recipe!
  after_destroy :touch_recipe!

  default_scope { order("position asc") }

  def fork_for(recipe)
    Instruction.create(
      body: body,
      position: position,
      recipe_id: recipe.id
    )
  end

  def touch_recipe!
    Recipe.find(recipe_id).touch
  end
end
