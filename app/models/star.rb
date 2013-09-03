class Star < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates :user_id, :recipe_id, presence: :true
end
