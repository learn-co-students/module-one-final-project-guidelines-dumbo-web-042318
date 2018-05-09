require_relative './scraper.rb'
require 'pry'

i = 0
while i < 10
    Location.create(Scraper.new.scrape_hash(i))
    i += 1
end

