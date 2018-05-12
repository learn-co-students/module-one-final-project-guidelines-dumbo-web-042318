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
