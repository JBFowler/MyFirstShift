class AddVerifyFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :drivers_license_number, :string
    add_column :users, :drivers_license_expiration, :date
    add_column :users, :passport_number, :string
    add_column :users, :passport_expiration, :date
  end
end
