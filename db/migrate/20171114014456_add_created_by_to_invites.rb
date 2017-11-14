class AddCreatedByToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :created_by_user_id, :integer
  end
end
