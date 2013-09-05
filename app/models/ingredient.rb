class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :food, :recipe_id, presence: true

  def fork_for(recipe)
    Ingredient.create(
      food: food,
      magnitude: magnitude,
      units: units,
      recipe_id: recipe.id
    )
  end
end
