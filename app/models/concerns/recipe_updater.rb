module RecipeUpdater
  extend ActiveSupport::Concern

  def touch_recipe!
    Recipe.find(recipe_id).touch
  end
end