class ShowTime < ActiveRecord::Base
  belongs_to :location
  belongs_to :movie
end
