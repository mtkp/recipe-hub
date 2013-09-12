class MoveMagnitudeToCount < ActiveRecord::Migration
  def up
    Ingredient.all.each do |ingredient|
      ingredient.count = ingredient.magnitude
      ingredient.save!
    end
  end
  def down
  end
end
