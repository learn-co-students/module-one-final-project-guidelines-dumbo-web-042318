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

  def self.create_new_tag(tag_name)
    Tag.create(t_content: tag_name)
  end

  def self.create_tag_answer(tag, answer)
    TagAnswer.create(tag: tag, answer: answer)
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

  def self.list_all_tags
    tags = Tag.all
    tags.each_with_index do |tag,i|
      print "#{i+1}. #{tag.t_content} | "
      puts "\n" if (i+1) % 5 == 0
    end
    puts ""
  end

  def self.list_questions_by_tag(tag)
    arr = self.get_all_answered_questions
    arr.each_with_index do |question, i|
      if question.answer.tags.include?(tag)
        puts "#{i+1} #{question.question}"
        puts "- #{question.answer.answer}"
        self.list_question_tags(question)
      end
    end
  end

  def self.list_question_tags(question)
    puts "TAGS: "
    question.answer.tags.each {|tag| print tag.t_content + ' | '}
    puts "\n\n"
  end

  # THIS ONE
  def self.all_questions_with_answers
    arr = self.get_all_answered_questions
    arr.each_with_index do |question, i|
      puts "#{i+1}. #{question.question}"
      puts  "-" * 20
      puts "#{question.answer.answer}"
      puts  "-" * 20
      # self.list_question_tags(question)
    end
  end

  def self.list_all_links
    puts "Download iTerm2(TM) to visit links from command line by holding cmd when you click."
    links = Link.all
    links.length.times { |i| puts "#{i+1}. #{links[i].url}\n#{links[i].comment}" }
  end

  def self.print_links(answer)
    answer.links.each do |link|
      puts "* #{link.url}\n\t#{link.comment}"
    end
  end

  # THIS ONE
  def self.list_everything
    self.get_all_answered_questions.each_with_index do |q, i|
      puts  "-" * 20
      puts "#{i+1}. #{q.question}"
      puts "-- #{q.answer.answer}" #TODO FIX THAT NAMING CONVENTION
      puts "Links:"
      self.print_links(q.answer)
      self.list_question_tags(q)
    end
  end

  # update methods

  def self.update_question(question)
    puts "What's your edited question?"
    input = gets.strip
    question.update(question: input)
  end

  def self.update_answer(answer)
    puts "What's your edited answer?"
    input = gets.strip
    answer.update(answer: input)
  end

  def self.update_link(link)
    puts "What's your edited link url?"
    new_url = gets.strip
    puts "What's your edited comment for the link?"
    new_comment = gets.strip
    link.update(url: new_url, comment: new_comment)
  end


  # selector methods

  def self.question_object_from_menu(index_from_menu)
    # BE SURE TO SHOW USER THE GET_ALL_QUESTIONS ARRAY FOR THE DELETE MENU
    arr = self.get_all_questions
    return arr[index_from_menu - 1]
  end

    # delete methods

  def self.destroy_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_question(question)
  end

  def self.destroy_answer_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_links(question)
    self.destroy_answer(question)
  end

  def self.destroy_question_answer_links_tags(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_all_tags_from_question(question)
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

  def self.destroy_tag_from_answer(tag,answer)
    tag_answer = TagAnswer.where("tag_id = ? AND answer_id = ?", tag[:id], answer[:id])[0]
    tag_answer.destroy
  end

  def self.destroy_all_tags_from_question(question)
    tags = question.answer.tags
    tags.each { |tag| self.destroy_tag_from_answer(tag,question.answer) }
  end

  def self.destroy_tag_from_all(tag)
    TagAnswer.where("tag_id = ?", tag[:id]).destroy_all
    tag.destroy
  end


  # not for user, eventually private
  def self.set_link_answer(link, answer)
    LinkAnswer.create(link_id: link.id, answer_id: answer.id)
  end

end


class Menu
  def self.main_menu_options
    puts "1. Add question/answer/link/tags"
    puts "2. Show All questions/answers/links/tags"
    puts "3. Show all question by tag"
    puts "4. Delete a question/answer/link/tag"
    puts "Press q to exit"
  end

  def self.new_link_tag_y_n(option)
    puts "would you like to add a #{option}?"
    puts "y/n (lowercase, just the letter)"
  end
end

class MenuCommands
  def self.yes_no_loop
    loop do
      choice = gets.strip.downcase
      if choice == "y"
        return true
      elsif choice == "n"
        return false
      else
        puts "sorry, didn't get that, try again. y or n"
      end
    end
  end

  def self.command1
    new_question = Interface.set_question
    new_answer = Interface.set_answer(new_question)
    loop do
      Menu.new_link_tag_y_n("link")
      self.yes_no_loop ? Interface.set_link(new_answer) : break
    end
    loop do
      Menu.new_link_tag_y_n("tag")
      choice = gets.strip.downcase
      if choice == "y"
        Interface.list_all_tags
        puts "enter the number of the tag to add it"
        puts "or type in a new tag and press enter"
        choice = gets.strip.downcase
        if choice.to_i == 0
          new_tag = Interface.create_new_tag(choice)
          Interface.create_tag_answer(new_tag, new_answer)
        else
          num_tag = Tag.all[choice.to_i - 1]
          Interface.create_tag_answer(num_tag, new_answer)
        end
      else
        break
      end
    end
  # end of method
  end
  # end of class
end

def run
  loop do
    puts "what would you like to do? "
    Menu.main_menu_options
    choice = gets.strip
    case choice
      when "1"
        MenuCommands.command1
      when "2"
        puts "Here are all your questions, answers, links, and tags!"
        Interface.list_everything
      when "3"
        Interface.list_all_tags
        puts "enter the number of the tag to see the questions linked to them"
        choice = gets.strip
        Interface.list_questions_by_tag(Tag.all[choice.to_i  - 1])
      when "4"
        puts "enter the number of the question/answer/link/tag you want to delete"
        Interface.all_questions_with_answers
        choice = gets.strip
        if choice.to_i != 0
          Interface.destroy_question_answer_links_tags(choice.to_i)
        else
          break
        end
      when "q"
        puts "bye!"
        break
      else
        puts "Hmmm, didn't get that try again."
    end
  end
end
