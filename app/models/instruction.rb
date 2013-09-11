class Instruction < ActiveRecord::Base
  include Duplication, RecipeUpdater
  belongs_to :recipe

  validates :body, :recipe_id, presence: :true

  after_save :touch_recipe!
  after_destroy :touch_recipe!

  default_scope { order("position asc") }


  # add to end of list
  def append_to_list
    self.position = self.class.where(recipe_id: recipe_id).last.try(:position)
    increment(:position) # instruction is not yet saved
    self.save
  end

  
  def remove_from_list
    displaced_list_items = self.class.where [ "recipe_id = ? and position > ?",
                                              recipe_id, position ]
    if displaced_list_items.any?
      displaced_list_items.each { |i| i.decrement! :position }
    end
    self.destroy
  end


end
