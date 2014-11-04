# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..5
	User.create(first_name: "John#{i}", last_name: "Smith#{i}", email_address: "john@smith.com", about_me: "Hey I'm John!", username: "jsmith#{i}", password: "password", user_type: "standard", city: "San Francisco", state: "CA")
end

for i in 1..5
	Business.create(name: "Cool Gym#{i}", business_type: "Gym", address: "201 Van Ness Avenue", city: "San Francisco", state: "CA", zipcode: "94119", phone: 4156577565, website: "http://google.com", availability: "Always open", description: "We are the coolest gym around! Come join us!")
end

for i in 1..5
	Review.create(user_id: i, bus_id: i, star_rating: i, review_text: "This place was awesome! Really loved it and thought the staff was really super nice!")
end