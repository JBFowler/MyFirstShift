class AddForeignKeysToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :organization_id, :integer
    add_column :videos, :unit_id, :integer
  end
end
