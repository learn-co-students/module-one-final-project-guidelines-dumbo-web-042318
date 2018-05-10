class Query < ActiveRecord::Base
  belongs_to :user
  belongs_to :batch
  # has_many :forecasts, through: :batches

end
