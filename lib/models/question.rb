class Question < ActiveRecord::Base
  has_one :answer
  # has_many :links, through: :answer
end
