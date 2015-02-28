class AddParentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer
    add_index :comments, :parent_id
  end
end
