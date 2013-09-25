module Duplication
  extend ActiveSupport::Concern

  def create_dup!(hash = {})
    dup_object = self.dup
    hash.each do |k, v| 
      dup_object[k] = v
    end
    dup_object.save!
    dup_object
  end
end