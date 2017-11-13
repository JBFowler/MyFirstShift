class AddHourlyPayToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hourly_pay, :integer
  end
end
