class AddStoreFrontToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :store_front, :string
  end
end
