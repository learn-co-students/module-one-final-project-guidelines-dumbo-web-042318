class CommandHelper
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

end
