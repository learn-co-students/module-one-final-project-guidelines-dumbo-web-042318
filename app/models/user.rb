class User < ActiveRecord::Base
  has_many :queries
  has_many :batches, through: :queries

  def forecasts
    my_forecasts = []
    batches.reload.each do |batch|
      my_forecasts << batch.forecasts
    end
    my_forecasts
  end

end
