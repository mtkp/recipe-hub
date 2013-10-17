class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :recipes, through: :taggings

  validates :name, presence: true,
                   uniqueness: true

  before_validation :remove_whitespace_and_uppercase

  def to_param
    name
  end

  # def self.search(string)
  #   if string && !string.empty?
  #     where(['lower(name) LIKE ?', "%#{string}%".downcase]).order(:updated_at)
  #   end
  # end

  private
    def remove_whitespace_and_uppercase
      return if name.nil?
      name.strip!
      name.downcase!
    end

end
