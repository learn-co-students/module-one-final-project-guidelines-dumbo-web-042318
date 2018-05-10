class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :link_answers
  has_many :links, through: :link_answers
  has_many :tag_answers
  has_many :tags, through: :tag_answers
end
