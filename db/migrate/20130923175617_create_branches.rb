class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :position
      t.references :recipe, index: true
      t.references :collection, index: true
    end
  end
end
