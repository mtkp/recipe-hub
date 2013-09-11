class Ingredient < ActiveRecord::Base
  include Duplication, RecipeUpdater
  belongs_to :recipe

  validates :food, :recipe_id, presence: true
  after_save :touch_recipe!
  after_destroy :touch_recipe!

end
