class AddRoleAndExpiresToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :role, :string, default: "member"
    add_column :invites, :expires_at, :datetime
  end
end
