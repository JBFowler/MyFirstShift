class AddDefaultValueToAdminAttribute < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :admin, :boolean, :default => false
    change_column :users, :role, :string, :default => "member"
  end
end
