class Query < ActiveRecord::Base
  belongs_to :user
  belongs_to :forecast

end
