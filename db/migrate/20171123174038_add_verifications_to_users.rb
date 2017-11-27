class AddVerificationsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :e_verified, :boolean, default: false
    add_column :users, :state_verified, :boolean, default: false
  end
end
