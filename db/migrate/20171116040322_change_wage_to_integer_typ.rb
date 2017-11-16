class ChangeWageToIntegerTyp < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :wage, :integer
  end
end
