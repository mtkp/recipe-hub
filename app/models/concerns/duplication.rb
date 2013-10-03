module Duplication
  extend ActiveSupport::Concern

  def create_dup!(change_params = {})
    dup_object = self.dup
    change_params.each do |k, v| 
      dup_object[k] = v
    end
    dup_object.save!
    dup_object
  end
end