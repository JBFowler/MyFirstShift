class AddWagesToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :wages, :integer, array: true, default: [8, 10]
  end
end
