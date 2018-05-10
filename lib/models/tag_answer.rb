class TagAnswer < ActiveRecord::Base
  belongs_to :tag
  belongs_to :answer
end
