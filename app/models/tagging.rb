class Tagging < ActiveRecord::Base
  include RecipeUpdater

  belongs_to :tag
  belongs_to :recipe

  after_save :touch_recipe!

end
