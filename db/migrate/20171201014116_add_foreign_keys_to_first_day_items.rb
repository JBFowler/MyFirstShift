class AddForeignKeysToFirstDayItems < ActiveRecord::Migration[5.0]
  def change
    add_column :first_day_items, :organization_id, :integer
    add_column :first_day_items, :unit_id, :integer
  end
end
