class AddForeignKeysToPolicies < ActiveRecord::Migration[5.0]
  def change
    add_column :policies, :organization_id, :integer
    add_column :policies, :unit_id, :integer
  end
end
