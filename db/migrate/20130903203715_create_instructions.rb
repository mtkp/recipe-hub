class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.text :body
      t.belongs_to :recipe, index: true
      t.integer :position

      t.timestamps
    end
  end
end
