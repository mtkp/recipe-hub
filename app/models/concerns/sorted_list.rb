module SortedList
  extend ActiveSupport::Concern

  # add to end of list
  def append_to_list
    self.position = list.last.try(:position)
    increment(:position)
    self.save
  end

  # remove direction from list
  def remove_from_list
    list.where("position > ?", position).
      try(:each) { |list_item| list_item.decrement! :position }
    self.destroy
  end
end