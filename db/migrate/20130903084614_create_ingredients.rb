class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :food
      t.integer :magnitude
      t.string :units
      t.belongs_to :recipe, index: true

      t.timestamps
    end
  end
end
