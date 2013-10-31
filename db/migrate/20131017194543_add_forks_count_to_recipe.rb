class AddForksCountToRecipe < ActiveRecord::Migration
  def up
    add_column :recipes, :forks_count, :integer, default: 0

    Recipe.all.each do |recipe|
      Recipe.update_counters(recipe.id, forks_count: recipe.forks.count)
    end
  end

  def down
    remove_column :recipes, :forks_count
  end
end
