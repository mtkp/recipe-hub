class AddColumnToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :count, :decimal, precision: 6, scale: 2
  end
end
