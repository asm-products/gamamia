class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :title
      t.string :thumbnail
      t.string :category
      t.string :embed
      t.references :game, index: true

      t.timestamps
    end
  end
end
