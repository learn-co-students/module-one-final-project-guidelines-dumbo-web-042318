class CreateTagsTagAnswersTables < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :t_content
    end

    create_table :tag_answers do |t|
      t.integer :tag_id
      t.integer :answer_id
    end
  end
end
