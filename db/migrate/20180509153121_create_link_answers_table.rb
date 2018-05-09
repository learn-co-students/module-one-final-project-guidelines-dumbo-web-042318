class CreateLinkAnswersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :link_answers do |t|
      t.integer :link_id
      t.integer :answer_id
    end
  end
end
