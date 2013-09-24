class Direction < ActiveRecord::Base
  include Duplication, RecipeUpdater
  belongs_to :recipe

  validates :body, :recipe_id, presence: :true

  after_save :touch_recipe!
  after_destroy :touch_recipe!

  default_scope { order("position asc") }


  # add to end of list
  def append_to_list
    self.position = list.last.try(:position)
    increment(:position)
    self.save
  end

  # remove direction from list
  def remove_from_list
    list.where("position > ?", position).
      try(:each) { |list_item| list_item.decrement! :position }
    self.destroy
  end

  private

    def list
      self.class.where(recipe_id: recipe_id)
    end

end
