class Movie < ActiveRecord::Base
  has_many :show_times, :foreign_key => 'movie_id'
end
