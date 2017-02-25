class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :code
      t.string :email
      t.integer :organization_id
      t.string :subdomain
      t.timestamps
    end
  end
end
