class AddRedeemedToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :redeemed_at, :datetime
    add_column :invites, :redeemed_by, :integer
  end
end
