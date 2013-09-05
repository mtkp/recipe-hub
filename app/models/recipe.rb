class Recipe < ActiveRecord::Base

  # stars
  has_many :stars, dependent: :destroy
  has_many :users, through: :stars
  
  # pieces of the recipe
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :instructions, dependent: :destroy

  # recipe forks
  has_many :forks, foreign_key: "source_id", dependent: :destroy
  has_many :forked_recipes, through: :forks, source: :fork
  has_one  :source, foreign_key: "fork_id", class_name: "Fork",
                    dependent: :destroy
  has_one  :source_recipe, through: :source, source: :source
  delegate :user, to: :source_recipe, prefix: true

  validates :title, :user_id, presence: true

  def fork_for(user)
    recipe_fork = Recipe.create(
      title: title,
      notes: notes,
      user_id: user.id
    )

    ingredients.each { |i| i.fork_for(recipe_fork) }
    instructions.each { |i| i.fork_for(recipe_fork) }

    Fork.create(source_id: id, fork_id: recipe_fork.id)
    recipe_fork
  end

end
