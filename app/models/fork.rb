class Fork < ActiveRecord::Base
  belongs_to :source, class_name: 'Recipe'
  belongs_to :fork, class_name: 'Recipe'

  validates :source_id, :fork_id, presence: true
  validate  :cannot_fork_self

  def cannot_fork_self
    if source_id == fork_id
      errors.add(:source_id, "Cannot fork this recipe into itself.")
    end
  end
end
