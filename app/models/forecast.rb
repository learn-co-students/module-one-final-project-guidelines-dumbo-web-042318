class Forecast < ActiveRecord::Base
  has_many :queries, :foreign_key => "batch_id"
  has_many :users, through: :queries

end
