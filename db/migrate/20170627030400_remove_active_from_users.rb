class RemoveActiveFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :active
  end
end
