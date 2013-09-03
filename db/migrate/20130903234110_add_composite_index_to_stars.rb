class AddCompositeIndexToStars < ActiveRecord::Migration
  def change
    add_index :stars, [:recipe_id, :user_id], unique: true
  end
end
