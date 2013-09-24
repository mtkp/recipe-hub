class Collection < ActiveRecord::Base
  has_many :branches, dependent: :destroy
  has_many :recipes, through: :branches

  belongs_to :user
end
