class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :link_answers
  has_many :links, through: :link_answers
end
