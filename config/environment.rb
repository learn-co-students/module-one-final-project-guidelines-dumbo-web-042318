require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

def run_four_twenty_tripster
    puts "Welcome to the 420 tripster"
    puts "Would you like to begin your trip? (for sure / nah brah)"
    begin_answer = gets.chomp
    if begin_answer == "nah brah"
        puts "well stay chill my bro, til the next episode"
    elsif begin_answer == "for sure"
        puts "tight, let's get this moving"
        puts 

    end 

end 