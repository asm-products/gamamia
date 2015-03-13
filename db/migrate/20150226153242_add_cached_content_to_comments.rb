class AddCachedContentToComments < ActiveRecord::Migration
  def up
    add_column :comments, :cached_content, :text
    Comment.all.map(&:cache_content!)
  end
  def down
    remove_column :comments, :cached_content
  end
end
