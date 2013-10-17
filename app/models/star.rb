class Star < ActiveRecord::Base
  belongs_to :recipe, counter_cache: true
  belongs_to :user

  validates :user_id, :recipe_id, presence: :true
end
