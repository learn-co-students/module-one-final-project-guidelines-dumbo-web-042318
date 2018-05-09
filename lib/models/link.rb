class Link < ActiveRecord::Base
  has_many :link_answers
  has_many :answers, through: :link_answers
end
