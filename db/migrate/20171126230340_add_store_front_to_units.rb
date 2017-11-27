class AddStoreFrontToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :store_front, :string
  end
end
