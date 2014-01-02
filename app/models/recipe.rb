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

  #pagination
  self.per_page = 10

  def self.search(string)
    if string.nil? or string.empty?
      none # return rails' "none" for empty search results (instead of nil)
    else
      search_recipes_and_associations_for string
    end
  end

  def self.duplicate!(recipe, change_params = {})
    recipe_dup = nil

    # ensure the counters are reset
    change_params.merge!({ forks_count: 0, stars_count: 0 })
    
    transaction do
      # dup the recipe
      recipe_dup = recipe.create_dup!(change_params)

      # dup the associated ingredients and directions
      dup_for_recipe_dup = ->i { i.create_dup!(recipe_id: recipe_dup.id) }
      recipe.ingredients.each &dup_for_recipe_dup
      recipe.directions.each &dup_for_recipe_dup
    end
    recipe_dup
  end

  private
    def self.searchify(string)
      string.downcase.strip if string
    end

    def self.search_titles_and_tags_for(string)
      searchify! string
      includes(:tags)
        .where(['lower(title) LIKE ? OR lower(tags.name) LIKE ?',
                "%#{string}%", "%#{string}%"])
        .references(:tags).order('stars_count desc')
    end

    def self.search_recipes_and_associations_for(string)
      s_str = searchify string

      # join ingredients, directions, tags to the recipe
      # search where the content of the recipe is like the string
      joins("LEFT JOIN ingredients ON ingredients.recipe_id = recipes.id
             LEFT JOIN directions ON directions.recipe_id = recipes.id
             LEFT JOIN taggings ON taggings.recipe_id = recipes.id
             LEFT JOIN tags on taggings.tag_id = tags.id")
        .where(['   lower(title)     LIKE ?
                 OR lower(notes)     LIKE ?
                 OR lower(body)      LIKE ?
                 OR lower(food)      LIKE ?
                 OR lower(tags.name) LIKE ?',
                "%#{s_str}%", "%#{s_str}%", "%#{s_str}%", "%#{s_str}%", "%#{s_str}%"])
        .distinct
        .order('stars_count desc')
    end

end


