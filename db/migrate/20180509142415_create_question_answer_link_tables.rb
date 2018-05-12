class CreateQuestionAnswerLinkTables < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :question
    end

    create_table :answers do |t|
      t.text :answer
      t.integer :question_id
    end

    create_table :links do |t|
      t.string :url
      t.string :comment
      t.integer :answer_id
    end
  end
end
