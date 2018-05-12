class TagAnswer < ActiveRecord::Base
  belongs_to :tag
  belongs_to :answer

#tag_answer
  def self.create_tag_answer(tag, answer)
    if tag 
      if answer.tags.include?(tag) 
        puts "You already added that tag!"
      else
        TagAnswer.create(tag: tag, answer: answer) 
      end
    else
     puts "You already made that tag!"
    end
  end

  #tag_answer
    def self.destroy_tag_from_answer(tag,answer)
      if answer
        tag_answer = TagAnswer.where("tag_id = ? AND answer_id = ?", tag[:id], answer[:id])[0]
        tag_answer.destroy
      end
    end

end
