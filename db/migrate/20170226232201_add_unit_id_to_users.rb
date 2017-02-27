class AddUnitIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :unit_id, :integer
  end
end
