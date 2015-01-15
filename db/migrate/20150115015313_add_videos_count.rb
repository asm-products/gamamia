class AddVideosCount < ActiveRecord::Migration
  def self.up  
    add_column :games, :videos_count, :integer, :default => 0
  end  
  
  def self.down  
    remove_column :games, :videos_count  
  end 
end
