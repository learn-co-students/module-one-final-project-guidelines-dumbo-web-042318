class User < ActiveRecord::Base
  has_many :queries
  has_many :forecasts, through: :queries
end
