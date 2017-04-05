class AddIndexToInvitesCode < ActiveRecord::Migration[5.0]
  def change
    add_index :invites, :code, unique: true
  end
end
