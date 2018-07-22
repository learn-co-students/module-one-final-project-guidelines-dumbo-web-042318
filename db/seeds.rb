# # Check your table before running this file
#
#
# #Movies
# jack_brown = Movie.create(title: "Jack Brown", genre: "Crime Dramas", rating: 8)
#
# charlie_countryman = Movie.create(title: "Charlie Countryman", genre: "Romantic Dramas", rating: 6)
#
# raw = Movie.create(title: "Raw", genre: "Gory", rating: 3)
#
# #Locations
# nighthawk = Location.create(theater_name: "Nighthawk", address: "136 Metropolitan Ave", neighborhood: "Williamsburg")
#
# amc = Location.create(theater_name: "AMC Fresh Meadows 7", address: "190-02 Horace Harding Expy", neighborhood: "Fresh Meadows")
#
# # ipic = Location.create(theater_name: "Ipic Fulton Market", address: "11 Fulton St", neighborhood: "Financial District")
#
# #Showtimes
# show_time1 = ShowTime.create(time: 20180509040000, price: 10, three_d: true, location_id: 3, movie_id: 3)
#
# show_time2 = ShowTime.create(time: 20180509070000, price: 10, three_d: false, location_id: 1, movie_id: 2)
#
# show_time3 = ShowTime.create(time: 20180509090000, price: 10, three_d: false, location_id: 2, movie_id: 1)
#
# show_time4 = ShowTime.create(time: 20180509050000, price: 10, three_d: false, location_id: 3, movie_id: 2)
#
# show_time5 = ShowTime.create(time: 20180509060000, price: 10, three_d: true, location_id: 1, movie_id: 3)


# Creating new showtimes
show_time10 = ShowTime.create(time: "8PM", price: 30, three_d: true, location_id: 1, movie_id: 4)

show_time11 = ShowTime.create(time: "8PM", price: 10, three_d: false, location_id: 1, movie_id: 5)

show_time12 = ShowTime.create(time: "8PM", price: 10, three_d: false, location_id: 2, movie_id: 10)
