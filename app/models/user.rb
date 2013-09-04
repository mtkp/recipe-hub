class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :stars, dependent: :destroy

  def has_starred?(recipe)
    stars.find_by(recipe_id: recipe.id)
  end
end
