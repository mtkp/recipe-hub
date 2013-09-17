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

  validates :title, :user_id, presence: true

  def fork_for(user)
    recipe_fork = nil
    transaction do
      # dup the recipe
      recipe_fork = dup_with!(user_id: user.id)

      # dup the associated ingredients and directions
      dup_for_recipe_fork = ->i { i.dup_with!(recipe_id: recipe_fork.id) }
      ingredients.each &dup_for_recipe_fork
      directions.each &dup_for_recipe_fork

      # create a record in the fork table
      Fork.create(source_id: self.id, fork_id: recipe_fork.id)
    end

    recipe_fork
  end

end
