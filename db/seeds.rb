require 'csv'
require 'open-uri'
require 'uri'

filepath = 'db/fixtures/boats.csv'

puts 'Cleaning the database'

User.destroy_all
Boat.destroy_all

puts 'Creating the users'

user1 = User.new(
  first_name: 'Adèle',
  last_name: 'Lesage',
  email: 'adele@gmail.com',
  password: 'adele23'
)
user1.save!

user2 = User.new(
  first_name: 'Cédric',
  last_name: 'Le Brun',
  email: 'cedric@gmail.com',
  password: 'cedric'
)
photocedleb = URI.open('https://res.cloudinary.com/dz21jxux5/image/upload/v1657201107/cedric_lebrun_photo_d1sw55.jpg')
user2.photo.attach(io: photocedleb, filename: 'cedleb.png', content_type: 'image/png')
user2.save!

user3 = User.new(
  first_name: 'Pascal',
  last_name: 'Le Brun',
  email: 'pascal@gmail.com',
  password: 'pascal'
)
user3.save!

user4 = User.new(
  first_name: 'Véronique',
  last_name: 'Le Brun',
  email: 'veronique@gmail.com',
  password: 'veronique'
)
user4.save!

user5 = User.new(
  first_name: 'Ludovic',
  last_name: 'Lesage',
  email: 'ludovic@gmail.com',
  password: 'ludovic'
)
user5.save!

user6 = User.new(
  first_name: 'Marie-Hélène',
  last_name: 'Gandon',
  email: 'madou@gmail.com',
  password: 'madou00'
)
user6.save!

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

puts 'Creating total_scores'

User.all.each do |user|
  TotalScore.create(user: user)
end

puts 'Creating total_scores done'

puts 'Creating bets'
["ULTIM", "IMOCA", "OCEANFIFTY", "CLASS40", "RHUMMONO", "RHUMMULTI"].each do |category|
  x = 7
  i = 0
  User.all.each do |user|
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::ULTIM[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::IMOCA[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::OCEANFIFTY[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::CLASS40[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::RHUMMONO[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 1, boat: Boat.where(name: Boat::RHUMMULTI[i % x].reverse.split(' - ', 2).last.reverse).first)
    i += 1
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::ULTIM[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::IMOCA[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::OCEANFIFTY[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::CLASS40[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::RHUMMONO[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 2, boat: Boat.where(name: Boat::RHUMMULTI[i % x].reverse.split(' - ', 2).last.reverse).first)
    i += 1
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::ULTIM[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::IMOCA[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::OCEANFIFTY[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::CLASS40[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::RHUMMONO[i % x].reverse.split(' - ', 2).last.reverse).first)
    Bet.create(user: user, position: 3, boat: Boat.where(name: Boat::RHUMMULTI[i % x].reverse.split(' - ', 2).last.reverse).first)
  end
end

puts 'Creating bets done'

puts 'Creating leagues'

league1 = League.new(
  title: 'Family'
)
logo = URI.open('https://res.cloudinary.com/dz21jxux5/image/upload/v1657201107/cedric_lebrun_photo_d1sw55.jpg')
league1.logo.attach(io: logo, filename: 'logo.png', content_type: 'image/png')
league1.user = user2
league1.save!

puts 'Creating leagues done'

puts 'Creating admissions'

User.all.each do |user|
  unless user == user2
    Admission.create(user: user, league: league1)
  end
end

puts 'Creating admissions done'
