class Menu
  def self.main_menu_options
    puts "Enter the number of the action you would like to perform \n\n"
    puts "1. Add question/answer/link/tags"
    puts "2. Show All questions/answers/links/tags"
    puts "3. Show all question by tag"
    puts "4. Add new links and tags to question" 
    puts "5. Update question and answer"
    puts "6. Delete a question/answer/link/tag"
    puts "\nEnter q to exit"
  end

  def self.new_link_or_tag_y_n(option)
    puts "Would you like to add a #{option}?"
    # puts "y/n (lowercase, just the letter)"
  end


  def self.edit_question(question)
    puts "Here is what you had for a question:\n\n"
    puts "-" * 40 
    puts question.question
    puts "-" * 40 + "\n\n"
    puts "Would you like to edit this?"
  end

  def self.edit_answer(answer)
    puts "Here is what you had for an answer:\n\n"
    puts "-" * 40
    puts answer.answer
    puts "-" * 40 + "\n\n"
    puts "Would you like to edit this?"
  end

end

class TerminalUtilities
  def self.pause_terminal_clear
    puts "Scroll up to see all entries, press enter to go back"
    gets
  end

  def self.clear_screen
    puts "\n" * 200
    puts `clear`
  end
end

class MenuCommands
  # utility commands
  def self.yes_no_loop
    puts "y/n (lowercase, just the letter)"
    loop do
      choice = gets.strip.downcase
      if choice == "y"
        return true
      elsif choice == "n"
        return false
      else
        puts "Sorry, didn't get that, try again. y or n"
      end
    end
  end

  def self.new_links_loop(answer)
    loop do
      Menu.new_link_or_tag_y_n("link")
      self.yes_no_loop ? Link.set_link(answer) : break
    end
  end

  def self.new_tags_loop(answer)
     loop do
       Menu.new_link_or_tag_y_n("tag")
       if self.yes_no_loop
         TerminalUtilities.clear_screen
         print "CURRENT "
         Tag.list_question_tags(answer.question)
         puts "All Tag options"
         Tag.list_all_tags
         puts "Enter the number of the tag to add it\nor type in a new tag and press enter"
         choice = gets.strip.downcase
         tag = (choice.to_i == 0) ? Tag.create_new_tag(choice) : Tag.all[choice.to_i - 1]
         TagAnswer.create_tag_answer(tag, answer)
       else # choice = false
         break
       end
     end

  end

  # main run methods
  def self.start
    puts `clear`
    Menu.main_menu_options
    puts "What would you like to do?"
    choice = gets.strip
    puts `clear`
    return choice
  end

  def self.make_new_q_a_l_t
    new_question = Question.set_question
    new_answer = Answer.set_answer(new_question)
    # make links
    self.new_links_loop(new_answer)
    # make tags
    self.new_tags_loop(new_answer)  
  end

  def self.show_everything
    TerminalUtilities.clear_screen
    Question.list_everything
    TerminalUtilities.pause_terminal_clear
  end

  def self.pick_tag_questions_by_number
    Tag.list_all_tags
    puts "Enter the number of the tag to see the questions linked to them, enter any letter to go back"
    choice = gets.strip
    TerminalUtilities.clear_screen
    if choice.to_i != 0 && choice.to_i <= Tag.all.length
      Question.list_questions_by_tag(Tag.all[choice.to_i  - 1])
      TerminalUtilities.pause_terminal_clear
    end
  end

  def self.delete_q_a_l_t
    Question.list_questions(Question.get_all_questions)
    puts "enter the number of the question you want to delete."
    puts "You will also delete the accompanying answer, links, and tags.\nEnter q to go back."
    choice = gets.strip
    choice.to_i == 0 ? "" : Question.destroy_question_answer_links_tags(choice.to_i)
  end

  def self.update_q_a
    Question.list_questions(Question.get_all_questions)
    puts "Enter the number of the question you want to edit.\nYou will be able to edit the answer, links, or tags as well\nEnter q to go back."
    choice = gets.strip.to_i
    question = Question.question_object_from_menu(choice)
    if choice != 0 && question
      TerminalUtilities.clear_screen
      Menu.edit_question(question)
      Question.update_question(question) if self.yes_no_loop

      TerminalUtilities.clear_screen
      Menu.edit_answer(question.answer)
      Answer.update_answer(question.answer) if self.yes_no_loop
    end
  end

  def self.add_l_t
    Question.list_questions(Question.get_all_questions)
    puts "Enter the number of the question you want to add links and tags to."
    choice = gets.strip
    question = Question.question_object_from_menu(choice.to_i)

    if choice == "q" 
      ""
    elsif choice.to_i != 0 && question 
      answer = question.answer
      self.new_links_loop(answer)
      self.new_tags_loop(answer)
    end
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
         MenuCommands.add_l_t
      when "5"
        MenuCommands.update_q_a
      when "6"
        MenuCommands.delete_q_a_l_t
      when "q"
        puts "bye!"
        break
      else
        puts "Hmmm, didn't get that try again."
    end
  end
end
