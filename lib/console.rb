class MenuCommands
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
    CommandHelper.new_links_loop(new_answer)
    CommandHelper.new_tags_loop(new_answer)  
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
      Question.update_question(question) if CommandHelper.yes_no_loop

      TerminalUtilities.clear_screen
      Menu.edit_answer(question.answer)
      Answer.update_answer(question.answer) if CommandHelper.yes_no_loop
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
      CommandHelper.new_links_loop(answer)
      CommandHelper.new_tags_loop(answer)
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
