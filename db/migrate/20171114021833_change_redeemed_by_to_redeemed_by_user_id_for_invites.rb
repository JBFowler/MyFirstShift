class ChangeRedeemedByToRedeemedByUserIdForInvites < ActiveRecord::Migration[5.0]
  def change
    rename_column :invites, :redeemed_by, :redeemed_by_user_id
  end
end
