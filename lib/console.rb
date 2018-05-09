class Interface
  def self.set_question
    puts "What's your question?"
    input = gets.strip
    Question.create(question: input)
  end

  def self.set_answer(question)
    puts "What's the answer?"
    input = gets.strip
    Answer.create(answer: input, question_id: question.id)
  end

  def self.set_link(answer)
    puts "What's the url?"
    input_url = gets.strip
    puts "And do you have a comment?"
    input_comment = gets.strip
    link = Link.create(url: input_url, comment: input_comment)
    set_link_answer(link, answer)
  end


  # builder
  def self.set_question_answer
    set_answer(set_question)
  end

  def self.list_all_questions
    Question.all.length.times do |i|
      puts "#{i+1}. #{Question.all[i].question}"
    end
  end


  #TODO refactor
  def self.list_all_answered_questions
    q = Question.all
    q.length.times { |i| puts q[i].question if q[i].answer}
  end

  def self.list_all_unanswered_questions
    q = Question.all
    q.length.times { |i| puts q[i].question unless q[i].answer}
  end




  # not for user, eventually private
  def self.set_link_answer(link, answer)
    LinkAnswer.create(link_id: link.id, answer_id: answer.id)
  end

end
