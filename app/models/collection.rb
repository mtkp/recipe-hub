class Collection < ActiveRecord::Base
  has_many :branches, dependent: :destroy
  has_many :recipes, through: :branches

  belongs_to :user

  validates :name, :user_id, presence: true

  def self.find_or_create_for_recipe(recipe)
    recipe.collection ||= Collection.create(user_id: recipe.user_id, name: recipe.title)
  end
end
