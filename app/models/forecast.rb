class Forecast < ActiveRecord::Base
  has_many :queries
  has_many :users, through: :queries
end
