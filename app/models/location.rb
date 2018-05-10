class Location < ActiveRecord::Base
  has_many :show_times, :foreign_key => 'location_id'
end
