class CreateForks < ActiveRecord::Migration
  def change
    create_table :forks do |t|
      t.integer :source_id
      t.integer :fork_id

      t.timestamps
    end

    add_index :forks, :source_id
    add_index :forks, :fork_id
    add_index :forks, [:source_id, :fork_id], unique: true
  end
end
