class AddUnitIdToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :unit_id, :integer
  end
end
