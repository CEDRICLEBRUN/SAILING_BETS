require 'csv'
require 'open-uri'
require 'uri'

filepath = 'db/fixtures/boats.csv'

puts 'Cleaning the database'

User.destroy_all
Boat.destroy_all

puts 'Creating the users'

user1 = User.new(
  first_name: 'Adele',
  last_name: 'Lesage',
  email: 'adele@gmail.com',
  password: 'adele23'
)
user1.save!

user2 = User.new(
  first_name: 'Cedric',
  last_name: 'Le Brun',
  email: 'cedric@gmail.com',
  password: 'cedric'
)
# photocedleb = URI.open('https://res.cloudinary.com/dz21jxux5/image/upload/v1657201107/cedric_lebrun_photo_d1sw55.jpg')
# user2.photo.attach(io: photocedleb, filename: 'cedleb.png', content_type: 'image/png')
user2.save!

puts 'Creating users done'

puts 'Creating boats'

CSV.foreach(filepath, headers: :first_row) do |row|
  boat = Boat.new(
    category: row['category'],
    name: row['name'],
    skipper_first_name: row['skipper_first_name'],
    skipper_last_name: row['skipper_last_name'],
    skipper_nationality: row['skipper_nationality'],
    url_link: row['url_link']
  )
  boat.save!
end

puts 'Creating boats done'
