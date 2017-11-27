class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
      t.text :question
      t.integer :organization_id
      t.integer :unit_id
    end
  end
end
