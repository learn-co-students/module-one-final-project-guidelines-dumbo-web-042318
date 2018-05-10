class Batch < ActiveRecord::Base
  has_many :forecasts
  belongs_to :query

end
