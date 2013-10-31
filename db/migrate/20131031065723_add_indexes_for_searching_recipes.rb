class AddIndexesForSearchingRecipes < ActiveRecord::Migration
  def change
    add_index :recipes, :title
    add_index :tags, :name
  end
end
