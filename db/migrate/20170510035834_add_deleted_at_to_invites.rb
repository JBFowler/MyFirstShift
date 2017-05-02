class AddDeletedAtToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :deleted_at, :datetime
    add_index :invites, :deleted_at
  end
end
