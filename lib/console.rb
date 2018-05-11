class Interface
#question
  def self.set_question
    puts "What's your question?"
    input = gets.strip
    Question.create(question: input)
  end
#answer
  def self.set_answer(question)
    puts "What's the answer?"
    input = gets.strip
    Answer.create(answer: input, question_id: question.id)
  end
# #link
#   def self.set_link(answer)
#     puts "What's the url?"
#     input_url = gets.strip
#     puts "And do you have a comment?"
#     input_comment = gets.strip
#     link = Link.create(url: input_url, comment: input_comment)
#     LinkAnswer.set_link_answer(link, answer)
#   end
# #tag
#   def self.create_new_tag(tag_name)
#     Tag.create(t_content: tag_name)
#   end
# #tag_answer
#   def self.create_tag_answer(tag, answer)
#     TagAnswer.create(tag: tag, answer: answer)
#   end


  # builder
#answer
  # def self.set_question_answer
  #   set_answer(set_question)
  # end

  # get arrays of question and answer combos
#question
  def self.get_all_questions
    return Question.all.map { |q| q }
  end

#question
  def self.get_all_answered_questions
    return Question.all.select { |q| q.answer != nil }
  end
#question
  def self.get_all_unanswered_questions
    return Question.all.select { |q| q.answer.nil? }
  end
#question
  def self.list_questions(arr)
    arr.length.times { |i| puts "#{i+1}. #{arr[i].question}" }
  end


  # gets and prints out various combos of q's, a's, and links
#tag
  # def self.list_all_tags
  #   tags = Tag.all
  #   tags.each_with_index do |tag,i|
  #     print "#{i+1}. #{tag.t_content} | "
  #     puts "\n" if (i+1) % 5 == 0
  #   end
  #   puts ""
  # end
#question
  def self.list_questions_by_tag(tag)
    arr = self.get_all_answered_questions
    arr.each_with_index do |question, i|
      if question.answer.tags.include?(tag)
        puts "#{i+1} #{question.question}"
        puts "- #{question.answer.answer}"
        Tag.list_question_tags(question)
      end
    end
  end
#tag
  # def self.list_question_tags(question)
  #   puts "TAGS: "
  #   question.answer.tags.each {|tag| print tag.t_content + ' | '}
  #   puts "\n\n"
  # end

  # THIS ONE
#question
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
#link
  def self.list_all_links
    puts "Download iTerm2(TM) to visit links from command line by holding cmd when you click."
    links = Link.all
    links.length.times { |i| puts "#{i+1}. #{links[i].url}\n#{links[i].comment}" }
  end
#link
  def self.print_links(answer)
    answer.links.each do |link|
      puts "* #{link.url}\n\t#{link.comment}"
    end
  end

  # THIS ONE
#question
  def self.list_everything
    self.get_all_answered_questions.each_with_index do |q, i|
      puts  "-" * 20
      puts "#{i+1}. #{q.question}"
      puts "-- #{q.answer.answer}" #TODO FIX THAT NAMING CONVENTION
      puts "Links:"
      self.print_links(q.answer)
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
#answer
  def self.update_answer(answer)
    puts "What's your edited answer?"
    input = gets.strip
    answer.update(answer: input)
  end
#link
  def self.update_link(link)
    puts "What's your edited link url?"
    new_url = gets.strip
    puts "What's your edited comment for the link?"
    new_comment = gets.strip
    link.update(url: new_url, comment: new_comment)
  end


  # selector methods
#question
  def self.question_object_from_menu(index_from_menu)
    # BE SURE TO SHOW USER THE GET_ALL_QUESTIONS ARRAY FOR THE DELETE MENU
    arr = self.get_all_questions
    return arr[index_from_menu - 1]
  end

    # delete methods
#question
  def self.destroy_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    self.destroy_question(question) if question
  end
#question??????
  def self.destroy_answer_links(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    if question
      self.destroy_links(question)
      self.destroy_answer(question)
    end
  end
#question
  def self.destroy_question_answer_links_tags(index_from_menu)
    question = self.question_object_from_menu(index_from_menu)
    if question
      self.destroy_all_tags_from_question(question)
      self.destroy_links(question)
      self.destroy_answer(question)
      self.destroy_question(question)
    end
  end
#question
  def self.destroy_question(question)
    question.destroy if question
  end
#question
  def self.destroy_answer(question)
    question.answer.destroy if question.answer
  end
#question
  def self.destroy_links(question)
    question.answer.links.each { |link| link.destroy } if question.answer
  end
# #tag_answer
#   def self.destroy_tag_from_answer(tag,answer)
#     if answer
#       tag_answer = TagAnswer.where("tag_id = ? AND answer_id = ?", tag[:id], answer[:id])[0]
#       tag_answer.destroy
#     end
#   end
#question
  def self.destroy_all_tags_from_question(question)
    if question.answer
      tags = question.answer.tags
      tags.each { |tag| TagAnswer.destroy_tag_from_answer(tag,question.answer) }
    end
  end
#tag
  # def self.destroy_tag_from_all(tag)
  #   if tag
  #     TagAnswer.where("tag_id = ?", tag[:id]).destroy_all
  #     tag.destroy
  #   end
  # end


#   # not for user, eventually private
# #link_answer
#   def self.set_link_answer(link, answer)
#     LinkAnswer.create(link_id: link.id, answer_id: answer.id)
#   end

end


class Menu
  def self.main_menu_options
    puts "1. Add question/answer/link/tags"
    puts "2. Show All questions/answers/links/tags"
    puts "3. Show all question by tag"
    puts "4. Delete a question/answer/link/tag"
    puts "Enter q to exit"
  end

  def self.new_link_or_tag_y_n(option)
    puts "would you like to add a #{option}?"
    puts "y/n (lowercase, just the letter)"
  end
end

class TerminalUtilities
  def self.pause_terminal_clear
    puts "scroll up to see all entries, enter any key to go back"
    choice = gets
  end

  def self.nicely_clear_terminal
    puts "\n" * 200
    puts `clear`
  end
end

class MenuCommands
  # utility commands
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

  # main run methods
  def self.start
    puts `clear`
    Menu.main_menu_options
    puts "what would you like to do?"
    choice = gets.strip
    puts `clear`
    return choice
  end

  def self.make_new_q_a_l_t
    new_question = Interface.set_question
    new_answer = Interface.set_answer(new_question)
    # make links
    loop do
      Menu.new_link_or_tag_y_n("link")
      self.yes_no_loop ? Link.set_link(new_answer) : break
    end
    # make tags
    loop do
      Menu.new_link_or_tag_y_n("tag")
      if self.yes_no_loop
        Tag.list_all_tags
        puts "enter the number of the tag to add it\nor type in a new tag and press enter"
        choice = gets.strip.downcase
        tag = (choice.to_i == 0) ? Tag.create_new_tag(choice) : Tag.all[choice.to_i - 1]
        TagAnswer.create_tag_answer(tag, new_answer)
      else # choice = false
        break
      end
    end
  end

  def self.show_everything
    TerminalUtilities.nicely_clear_terminal
    Interface.list_everything
    TerminalUtilities.pause_terminal_clear
  end

  def self.pick_tag_questions_by_number
    Tag.list_all_tags
    puts "enter the number of the tag to see the questions linked to them, enter any letter to go back"
    choice = gets.strip
    TerminalUtilities.nicely_clear_terminal
    choice.to_i == 0 ? "" : Interface.list_questions_by_tag(Tag.all[choice.to_i  - 1])
    TerminalUtilities.pause_terminal_clear
  end

  def self.delete_q_a_l_t
    Interface.list_questions(Interface.get_all_questions)
    puts "enter the number of the question you want to delete."
    puts "You will also delete the accompanying answer, links, and tags.\nEnter any letter to go back"
    choice = gets.strip
    choice.to_i == 0 ? "" : Interface.destroy_question_answer_links_tags(choice.to_i)
  end
end



def run
  loop do
    choice = MenuCommands.start
    case choice
      when "1"
        MenuCommands.make_new_q_a_l_t
      when "2"
        MenuCommands.show_everything
      when "3"
        MenuCommands.pick_tag_questions_by_number
      when "4"
        MenuCommands.delete_q_a_l_t
      when "q"
        puts "bye!"
        break
      else
        puts "Hmmm, didn't get that try again."
    end
  end
end
