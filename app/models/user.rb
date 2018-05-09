class User < ActiveRecord::Base
  has_many :queries
  has_many :forecasts, through: :queries

  def city_name
    a = gets.chomp.downcase
    # binding.pry
    a
  end

  def gimme_cc # gets country code
     a = gets.chomp.downcase
     a
  end

  # def create_query(city, country_code)
  #   Query.create(city: city, country_code: country_code, user: self)
  # end

end
