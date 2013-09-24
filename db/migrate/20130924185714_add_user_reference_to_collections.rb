class AddUserReferenceToCollections < ActiveRecord::Migration
  def change
    add_reference :collections, :user, index: true
  end
end
