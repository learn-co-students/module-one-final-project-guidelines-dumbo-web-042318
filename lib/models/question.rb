class Question < ActiveRecord::Base
  has_one :answer
  # has_many :links, through: :answer

  def self.set_question
    puts "What's your question?"
    input = gets.strip
    Question.create(question: input)
  end

  # get arrays of questions 
  def self.get_all_questions
    return Question.all.map { |q| q }
  end

  def self.get_all_answered_questions
    return Question.all.select { |q| q.answer != nil }
  end

  def self.get_all_unanswered_questions
    return Question.all.select { |q| q.answer.nil? }
  end

  def self.list_questions(arr)
    arr.length.times { |i| puts "#{i+1}. #{arr[i].question}" }
  end




  def self.list_questions_by_tag(tag)
    arr = Question.all.select { |question| question.answer.tags.include?(tag) }    
    arr.each_with_index do |question, i|
      if question.answer.tags.include?(tag)
        puts "-" * 42
        puts "#{i+1}. #{question.question}"
        puts "-- #{question.answer.answer}"
        Link.print_links(question.answer)
        Tag.list_question_tags(question)
      end
    end
    if arr.empty?
       puts "-" * 42 
       puts " There are no questions with that tag. :(" 
       puts "-" * 42 
    end
  end

  

#       if question.answer.tags.length == 0
#         puts "-" * 42 
#         puts " There are no questions with that tag. :(" 
#         puts "-" * 42 
#       end

  def self.list_everything
    Question.get_all_answered_questions.each_with_index do |q, i|
      puts  "-" * 40
      puts "#{i+1}. #{q.question}"
      puts "-- #{q.answer.answer}" #TODO FIX THAT NAMING CONVENTION
      Link.print_links(q.answer)
      Tag.list_question_tags(q)
    end
  end

  # update methods
#question
  def self.update_question(question)
    puts "What's your edited question?"
    input = gets.strip
    question.update(question: input)
  end

#   def self.all_questions_with_answers
#     arr = Question.get_all_answered_questions
#     arr.each_with_index do |question, i|
#       puts "#{i+1}. #{question.question}"
#       puts  "-" * 20
#       puts "#{question.answer.answer}"
#       puts  "-" * 20
#       # self.list_question_tags(question)
#     end
#   end

  def self.question_object_from_menu(index_from_menu)
    # BE SURE TO SHOW USER THE GET_ALL_QUESTIONS ARRAY FOR THE DELETE MENU
    arr = self.get_all_questions
    return arr[index_from_menu - 1]
  end

  # destroy methods 
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
    question = self.question_object_from_menu(index_from_menu)
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
