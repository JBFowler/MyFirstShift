class CreateManagersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :managers do |t|
      t.string :name
      t.string :role
      t.string :picture
      t.text :description
      t.integer :organization_id, index: true
      t.integer :unit_id, index: true
    end
  end
end
