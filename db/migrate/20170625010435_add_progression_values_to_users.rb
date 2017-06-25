class AddProgressionValuesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :progress, :string
    add_column :users, :phone, :string
    add_column :users, :employee_type, :string
    add_index :users, :progress
  end
end
