require_relative './scraper.rb'
# require 'pry'

i = 0
while i < 10
    Location.create(Scraper.new.scrape_hash(i))
    i += 1
end

User.create(name: "Saige", age: 22, home_state: "NY")
User.create(name: "Jesse", age: 30, home_state: "CT")

# first = FourTwentyTrip.create(date_of_trip: "April 20th, 2019")
# second = FourTwentyTrip.create(date_of_trip: "April 20th, 2020")
# third = FourTwentyTrip.create(date_of_trip: "April 20th, 2021")

