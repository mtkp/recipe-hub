class Recipe < ActiveRecord::Base
  include Duplication

  # stars
  has_many :stars, dependent: :destroy
  has_many :starring_users, through: :stars, source: :user
  
  # pieces of the recipe
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy

  # recipe forks
  has_many :forks, foreign_key: "source_id", dependent: :destroy
  has_many :forked_recipes, through: :forks, source: :fork
  has_one  :source, foreign_key: "fork_id", class_name: "Fork",
                    dependent: :destroy
  has_one  :source_recipe, through: :source, source: :source
  delegate :user, to: :source_recipe, prefix: true

  # recipe collections
  has_one :branch, dependent: :destroy
  has_one :collection, through: :branch

  # validations
  validates :title, :user_id, presence: true

  def self.duplicate!(recipe, change_params = {})
    recipe_dup = nil
    transaction do
      # dup the recipe
      recipe_dup = recipe.create_dup! change_params

      # dup the associated ingredients and directions
      dup_for_recipe_dup = ->i { i.create_dup!(recipe_id: recipe_dup.id) }
      recipe.ingredients.each &dup_for_recipe_dup
      recipe.directions.each &dup_for_recipe_dup
    end
    recipe_dup
  end


  def create_branch
    if collection.nil?
      new_collection = Collection.create(user_id: user_id, name: title)
      Branch.create(recipe_id: id, collection_id: new_collection.id)
      self.reload
    end
    recipe_branch = nil
    transaction do
      # dup the recipe
      recipe_branch = dup_with!(user_id: user_id)

      # dup the associated ingredients and directions
      dup_for_recipe_branch = ->i { i.dup_with!(recipe_id: recipe_branch.id) }
      ingredients.each &dup_for_recipe_branch
      directions.each &dup_for_recipe_branch

      # create a record in the fork table
      Branch.create(recipe_id: recipe_branch.id, collection_id: collection.id)
    end

    recipe_branch
  end

end
