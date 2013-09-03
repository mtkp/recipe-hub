class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients

  validates :title, :user_id, presence: true

end
