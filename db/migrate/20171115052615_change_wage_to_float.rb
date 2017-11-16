class ChangeWageToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :wage, :float
  end
end
