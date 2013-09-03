class Recipe < ActiveRecord::Base
  belongs_to :user
  
  has_many :ingredients, dependent: :destroy
  has_many :instructions, dependent: :destroy

  validates :title, :user_id, presence: true
end
