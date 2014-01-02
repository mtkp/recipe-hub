# Tagging concept from RailsCasts
module Taggable
  extend ActiveSupport::Concern

  included do
    def self.tagged_with(name)
      Tag.find_by_name!(name).send(self.model_name.plural)
    end
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip.downcase).first_or_create! unless n.empty?
    end
  end
end