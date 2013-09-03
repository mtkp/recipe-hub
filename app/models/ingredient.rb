class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :food, :recipe_id, presence: true
end
