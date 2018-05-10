class LinkAnswer < ActiveRecord::Base
  belongs_to :link
  belongs_to :answer

  # not for user, eventually private
  #link_answer
  def self.set_link_answer(link, answer)
    LinkAnswer.create(link_id: link.id, answer_id: answer.id)
  end

end
