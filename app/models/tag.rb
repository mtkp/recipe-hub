class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :recipes, through: :taggings
  before_save { name.downcase! }
end
