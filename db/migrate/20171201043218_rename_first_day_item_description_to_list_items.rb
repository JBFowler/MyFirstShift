class RenameFirstDayItemDescriptionToListItems < ActiveRecord::Migration[5.0]
  def change
    rename_column :first_day_items, :description, :list_items
  end
end
