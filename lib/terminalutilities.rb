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
