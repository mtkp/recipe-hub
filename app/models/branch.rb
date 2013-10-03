class Branch < ActiveRecord::Base
  include SortedList

  belongs_to :collection
  belongs_to :recipe

  validates :recipe_id, :collection_id, presence: true

  default_scope { order("position asc") }

  private

    def list
      self.class.where(collection_id: collection_id)
    end

end
