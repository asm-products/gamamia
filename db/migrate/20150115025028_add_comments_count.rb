class AddCommentsCount < ActiveRecord::Migration
  def self.up  
    add_column :games, :comments_count, :integer, :default => 0
  end  
  
  def self.down  
    remove_column :games, :comments_count  
  end 
end