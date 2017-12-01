class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :type
      t.string :name
      t.text :description
    end
  end
end
