class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :role, :string
    add_column :users, :active, :boolean
    add_column :users, :admin, :boolean
    add_column :users, :organization_id, :integer
  end
end
