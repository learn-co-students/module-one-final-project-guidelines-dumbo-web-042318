class User < ActiveRecord::Base
  has_many :queries
  has_many :batches, through: :queries

  def forecasts
    my_forecasts = []
    batches.each do |batch|
      my_forecasts << batch.forecasts
    end
    my_forecasts
  end
  # 
  # def order_batch
  #   self.forecasts.last.sort_by{|forecast| forecast.temp}
  # end

end
