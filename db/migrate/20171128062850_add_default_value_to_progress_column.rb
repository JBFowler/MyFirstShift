class AddDefaultValueToProgressColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :progress, :string, default: "Intro"
  end
end
