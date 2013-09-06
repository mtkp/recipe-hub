class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :food, :recipe_id, presence: true
  after_save :touch_recipe!
  after_destroy :touch_recipe!

  def fork_for(recipe)
    Ingredient.create(
      food: food,
      magnitude: magnitude,
      units: units,
      recipe_id: recipe.id
    )
  end

  def touch_recipe!
    Recipe.find(recipe_id).touch
  end
end
