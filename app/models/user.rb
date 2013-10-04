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
  RESERVED_WORDS = %w{ user username recipe ingredient direction fork star
                       devise sign_in sign_out sign_up admin }.
                       flat_map { |word| [word, "#{word}s"] }
  validates :username, presence: true
  validates :username, length: { minimum: 3, maximum: 20 },
                       uniqueness: { case_sensitive: false },
                       format: { with: VALID_USERNAME_REGEX }
  validate :exclusion_from_reserved_words
  before_save { username.downcase! }

  def has_starred?(recipe)
    stars.where(recipe_id: recipe.id).first
  end

  def to_param
    username
  end

  private

    def exclusion_from_reserved_words
      RESERVED_WORDS.each do |word|
        if username.try(:downcase).eql? word
          errors.add(:username, "is not available.")
          return
        end
      end
    end

end
