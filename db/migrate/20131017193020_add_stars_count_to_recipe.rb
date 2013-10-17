class AddStarsCountToRecipe < ActiveRecord::Migration
  def up
    add_column :recipes, :stars_count, :integer, default: 0

    Recipe.all.each do |recipe|
      Recipe.update_counters(recipe.id, stars_count: recipe.stars.count)
    end
  end

  def down
    remove_colum :recipes, :stars_count
  end
end
