class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :starred_recipes, through: :stars, source: :recipe

  # username hooks
  VALID_USERNAME_REGEX = /\A[\w]*[a-z]+[\w]*\z/i
  validates :username, presence: true,
                       length: { minimum: 3, maximum: 20 },
                       uniqueness: { case_sensitive: false },
                       format: { with: VALID_USERNAME_REGEX }
  before_save { username.downcase! }

  def has_starred?(recipe)
    stars.find_by(recipe_id: recipe.id)
  end
end
