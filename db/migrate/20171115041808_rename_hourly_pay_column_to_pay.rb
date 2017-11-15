class RenameHourlyPayColumnToPay < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :hourly_pay, :wage
  end
end
