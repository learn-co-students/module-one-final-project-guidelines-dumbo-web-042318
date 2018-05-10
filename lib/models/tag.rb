class Tag < ActiveRecord::Base
  has_many :tag_answers
  has_many :answers, through: :tag_answers
end
