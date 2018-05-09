class Interface
  def set_question
    puts "What's your question?"
    input = gets.strip
    Question.create(question: input)
  end

  def set_answer(question)
    puts "What's the answer?"
    input = gets.strip
    Answer.create(answer: input, question_id: question.id)
  end

  def set_question_answer
    set_answer(set_question)
  end
end
