class AddSlugToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :slug, :string
  end
end
