class Query < ActiveRecord::Base
  belongs_to :user
  belongs_to :forecast, :foreign_key => "batch_id"

end
