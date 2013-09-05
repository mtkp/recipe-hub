class Instruction < ActiveRecord::Base
  belongs_to :recipe
  validates :body, :position, :recipe_id, presence: :true

  default_scope { order("position asc") }

  def fork_for(recipe)
    Instruction.create(
      body: body,
      position: position,
      recipe_id: recipe.id
    )
  end
end
