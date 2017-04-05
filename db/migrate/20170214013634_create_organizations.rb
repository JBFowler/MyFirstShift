class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :size
      t.string :sector
      t.string :subdomain
      t.timestamps
    end
  end
end
