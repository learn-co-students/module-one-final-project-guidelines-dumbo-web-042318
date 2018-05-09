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

  # get arrays of question and answer combos
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

  # gets and prints out various combos of q's, a's, and links

  def self.all_questions_with_answers
    arr = self.get_all_answered_questions
    arr.each_with_index do |question, i|
      puts "#{i+1}. #{question.question}"
      puts  "-" * 20
      puts "#{question.answer.answer}"
      puts  "-" * 20 + "\n\n"
    end
  end

  def self.list_all_links
    puts "Download iTerm2(TM) to visit links from command line by holding cmd when you click."
    links = Link.all
    links.length.times { |i| puts "#{i+1}. #{links[i].url}\n#{links[i].comment}" }
  end

  def self.print_link(answer)
    answer.links.each do |link|
      puts "* #{link.url}\n\t#{link.comment}"
    end
  end

  def self.list_everything
    self.get_all_answered_questions.each_with_index do |q, i|
      puts  "-" * 20
      puts "#{i+1}. #{q.question}"
      puts "-- #{q.answer.answer}" #TODO FIX THAT NAMING CONVENTION
      puts "Links:"
      self.print_link(q.answer)
      puts ""
    end
  end


  # delete methods

  def self.question_object_from_menu(index_from_menu)
    # BE SURE TO SHOW USER THE GET_ALL_QUESTIONS ARRAY FOR THE DELETE MENU
    arr = self.get_all_questions
    return arr[index_from_menu - 1]
  end

  def self.destroy_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_question(question)
  end

  def self.destroy_answer_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_links(question)
    self.destroy_answer(question)
  end

  def self.destroy_question_answer_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_links(question)
    self.destroy_answer(question)
    self.destroy_question(question)
  end

  def self.destroy_question(question)
    question.destroy
  end

  def self.destroy_answer(question)
    question.answer.destroy
  end

  def self.destroy_links(question)
    question.answer.links.each { |link| link.destroy }
  end

  # not for user, eventually private
  def self.set_link_answer(link, answer)
    LinkAnswer.create(link_id: link.id, answer_id: answer.id)
  end

end
