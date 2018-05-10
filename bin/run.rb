require_relative '../config/environment'


new_cli = CommandLineInterface.new

new_cli.greeting


response1 = new_cli.find_movie_by_title
response2 = new_cli.find_by_location
response3 = new_cli.find_by_showtime
