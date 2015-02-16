class AddReceiveNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_newsletter, :boolean
  end
end
