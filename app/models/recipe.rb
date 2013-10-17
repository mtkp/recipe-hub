class Recipe < ActiveRecord::Base
  include Duplication
  include Taggable

  # stars
  has_many :stars, dependent: :destroy
  has_many :starring_users, through: :stars, source: :user
  
  # pieces of the recipe
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # recipe forks
  has_many :forks, foreign_key: "source_id", dependent: :destroy
  has_many :forked_recipes, through: :forks, source: :fork
  has_one  :source, foreign_key: "fork_id", class_name: "Fork",
                    dependent: :destroy
  has_one  :source_recipe, through: :source, source: :source
  delegate :user, to: :source_recipe, prefix: true

  # validations
  validates :title, :user_id, presence: true

  def self.search(string)
    if string && !string.empty?
      title_search = where(['lower(title) LIKE ?', "%#{string}%".downcase]).
        order(updated_at: :desc)
      tag_search = joins(:tags).where(['lower(tags.name) LIKE ?', "%#{string}%".downcase]).
        order(updated_at: :desc)
      (title_search + tag_search).uniq
    end
  end

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

end
