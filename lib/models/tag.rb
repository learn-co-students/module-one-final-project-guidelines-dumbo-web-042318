class Tag < ActiveRecord::Base
  has_many :tag_answers
  has_many :answers, through: :tag_answers

#tag
  def self.create_new_tag(tag_name)
    check = Tag.all.none? { |tag| tag.t_content.downcase == tag_name.downcase }
    check ? Tag.create(t_content: tag_name) : nil
  end

#tag
  def self.list_all_tags
    tags = Tag.all
    tags.each_with_index do |tag,i|
      print "#{i+1}. #{tag.t_content} | "
      puts "\n" if (i+1) % 5 == 0
    end
    puts ""
  end

#tag
  def self.list_question_tags(question)
    puts "TAGS: "
    question.answer.tags.each {|tag| print tag.t_content + ' | '}
    puts "\n\n"
  end

#tag
  def self.destroy_tag_from_all(tag)
    if tag
      TagAnswer.where("tag_id = ?", tag[:id]).destroy_all
      tag.destroy
    end
  end
end
