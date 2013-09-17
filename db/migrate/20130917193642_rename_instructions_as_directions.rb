class RenameInstructionsAsDirections < ActiveRecord::Migration
  def change
    rename_table 'instructions', 'directions'
  end
end
