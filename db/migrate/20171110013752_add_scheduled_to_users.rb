class AddScheduledToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :scheduled, :boolean, default: false
  end
end
