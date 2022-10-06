require 'csv'
require 'open-uri'
require 'uri'

filepath = 'db/fixtures/boats.csv'

puts 'Cleaning the database'

User.destroy_all
Boat.destroy_all

puts 'Creating boats'

CSV.foreach(filepath, headers: :first_row) do |row|
  boat = Boat.new(
    category: row.first.last,
    name: row['name'],
    skipper_last_name: row['skipper_last_name'],
    skipper_first_name: row['skipper_first_name'],
    skipper_nationality: row['nationality'],
    url_link: row['url_link']
  )
  boat.save!
end

puts 'Creating boats done'
