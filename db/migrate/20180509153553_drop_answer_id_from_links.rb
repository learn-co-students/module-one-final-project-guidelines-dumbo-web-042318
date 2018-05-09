class DropAnswerIdFromLinks < ActiveRecord::Migration[5.0]
  def change
    remove_column(:links, :answer_id)
  end
end
