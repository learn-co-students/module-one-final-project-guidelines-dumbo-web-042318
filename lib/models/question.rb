class Question < ActiveRecord::Base
  has_one :answer
  # has_many :links, through: :answer

  def self.destroy_all_tags_from_question(question)
    if question.answer
      tags = question.answer.tags
      tags.each { |tag| TagAnswer.destroy_tag_from_answer(tag,question.answer) }
    end
  end

  def self.destroy_links(question)
    question.answer.links.each { |link| link.destroy } if question.answer
  end

  def self.destroy_answer(question)
    question.answer.destroy if question.answer
  end

  def self.destroy_question(question)
    question.destroy if question
  end

  def self.destroy_question_answer_links_tags(index_from_menu)
    question = Interface.question_object_from_menu(index_from_menu)
    if question
      self.destroy_all_tags_from_question(question)
      self.destroy_links(question)
      self.destroy_answer(question)
      self.destroy_question(question)
    end
  end



  ########### This method has the same name as another method.
  ########### This method is not used anywhere
  #   def self.destroy_links(index_from_menu)
  #     question = self.question_object_from_menu(index_from_menu)
  #     self.destroy_question(question) if question
  #   end
end
