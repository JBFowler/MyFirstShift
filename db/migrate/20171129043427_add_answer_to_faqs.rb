class AddAnswerToFaqs < ActiveRecord::Migration[5.0]
  def change
    add_column :faqs, :answer, :text
  end
end
