class CreateFirstDayItems < ActiveRecord::Migration[5.0]
  def change
    create_table :first_day_items do |t|
      t.string :title
      t.text :description, array: true
    end
  end
end
