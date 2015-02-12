class AddDeletedAtToGames < ActiveRecord::Migration
  def change
    add_column :games, :deleted_at, :datetime
  end
end
