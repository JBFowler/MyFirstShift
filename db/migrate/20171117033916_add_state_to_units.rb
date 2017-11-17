class AddStateToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :state, :string
    rename_column :units, :location, :city
  end
end
