class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :link_answers
  has_many :links, through: :link_answers
  has_many :tag_answers
  has_many :tags, through: :tag_answers

  def self.set_answer(question)
    puts "What's the answer?"
    input = gets.strip
    Answer.create(answer: input, question_id: question.id)
  end
  def self.update_answer(answer)
    puts "What's your edited answer?"
    input = gets.strip
    answer.update(answer: input)
  end
#  def self.destroy_answer_links(index_from_menu)
#    question = Question.question_object_from_menu(index_from_menu)
#    if question
#      Question.destroy_links(question)
#      self.destroy_answer(question)
#    end
#  end
end
