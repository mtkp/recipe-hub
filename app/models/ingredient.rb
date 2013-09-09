class Ingredient < ActiveRecord::Base
  include Duplication
  belongs_to :recipe

  validates :food, :recipe_id, presence: true
  after_save :touch_recipe!
  after_destroy :touch_recipe!

  def touch_recipe!
    Recipe.find(recipe_id).touch
  end
end
