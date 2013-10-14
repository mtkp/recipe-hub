class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :recipes, through: :taggings

  validates :name, presence: true,
                   uniqueness: true

  before_validation :remove_whitespace_and_uppercase

  private
    def remove_whitespace_and_uppercase
      return if name.nil?
      name.strip!
      name.downcase!
    end

end
