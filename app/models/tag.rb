class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :recipes, through: :taggings

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  before_save { name.downcase! }
end
