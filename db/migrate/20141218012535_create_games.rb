class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :thumbnail
      t.string :description
      t.string :status
      t.string :link
      t.string :platform
      t.integer :votes

      t.timestamps
    end
  end
end
