class AddCreatedByUserIdToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :created_by_user_id, :integer
  end
end
