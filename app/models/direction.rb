class Direction < ActiveRecord::Base
  include Duplication, RecipeUpdater, SortedList
  belongs_to :recipe

  validates :body, :recipe_id, presence: :true

  after_save :touch_recipe!
  after_destroy :touch_recipe!

  default_scope { order("position asc") }

  private
    # defined for sorted list module
    def list
      self.class.where(recipe_id: recipe_id)
    end

end
