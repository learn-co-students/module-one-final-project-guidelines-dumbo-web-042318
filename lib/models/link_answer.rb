class LinkAnswer < ActiveRecord::Base
  belongs_to :link
  belongs_to :answer
end
