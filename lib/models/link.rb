class Link < ActiveRecord::Base
  has_many :link_answers
  has_many :answers, through: :link_answers

#link
  def self.set_link(answer)
    puts "What's the url?"
    input_url = gets.strip
    puts "Enter a short description for this site"
    input_comment = gets.strip
    link = Link.create(url: input_url, comment: input_comment)
    LinkAnswer.set_link_answer(link, answer)
  end

####This method is not used!
#  def self.list_all_links
#    links = Link.all
#    links.length.times { |i| puts "#{i+1}. #{links[i].url}\n#{links[i].comment}\n\n" }
#  end

  #link
    def self.print_links(answer)
      puts "LINKS:"
      answer.links.each do |link|
        puts "* #{link.url}\n\t#{link.comment}\n\n"
      end
    end

  ####This method is not used
#     def self.update_link(link)
#       puts "What's your edited link url?"
#       new_url = gets.strip
#       puts "What's your edited comment for the link?"
#       new_comment = gets.strip
#       link.update(url: new_url, comment: new_comment)
#     end
end
