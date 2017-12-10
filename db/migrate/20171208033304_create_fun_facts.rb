class CreateFunFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :fun_facts do |t|
      t.string :question
      t.string :answer
      t.integer :organization_id
      t.integer :user_id
      t.integer :unit_id
    end
  end
end
