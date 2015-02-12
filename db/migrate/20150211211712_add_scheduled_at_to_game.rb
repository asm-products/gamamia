class AddScheduledAtToGame < ActiveRecord::Migration
  def change
    add_column :games, :scheduled_at, :date
  end
end
