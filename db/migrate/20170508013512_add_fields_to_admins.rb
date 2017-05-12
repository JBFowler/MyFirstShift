class AddFieldsToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :username, :string
    add_column :admins, :admin, :boolean, :default => false, :null => false
    add_column :admins, :deleted_at, :datetime
    add_index :admins, :deleted_at
  end
end
