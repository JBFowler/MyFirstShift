class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :name
      t.integer :size
      t.string :location
      t.integer :organization_id
      t.timestamps
    end
  end
end
