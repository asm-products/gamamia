class AddExtendedDescriptionToGame < ActiveRecord::Migration
  def change
    add_column :games, :extended_description, :text
  end
end
