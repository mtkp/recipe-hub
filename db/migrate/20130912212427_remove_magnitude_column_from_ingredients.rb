class RemoveMagnitudeColumnFromIngredients < ActiveRecord::Migration
  def change
    remove_column :ingredients, :magnitude, :integer
  end
end
