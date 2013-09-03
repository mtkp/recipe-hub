class Instruction < ActiveRecord::Base
  belongs_to :recipe
  validates :body, :position, :recipe_id, presence: :true

  default_scope { order("position asc") }
end
