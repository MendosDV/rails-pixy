User.destroy_all
Category.destroy_all
Profile.destroy_all

puts "creation de categories"
Category.create(name: "Faible")
Category.create(name: "Modéré")
Category.create(name: "Elevé")

# low = Category.find_by(name: "Low")
# medium = Category.find_by(name: "Medium")
# hight = Category.find_by(name: "Hight")


puts "creation de users"

Tommy = User.create(email: "tommy@gmail.com", password: "123456", first_name: "Tommy", last_name: "Lam")
Boby = User.create(email: "boby@gmail.com", password: "123456", first_name: "boby", last_name: "Lam")

file_elise = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686231217/development/pixy/Elise_tmjg2f.jpg")
elise = User.new(
  email: 'Elise@gmail.com',
  password: '123456',
  first_name: 'Elise',
  last_name: 'Rochaix'
)
elise.avatar.attach(io: file_elise, filename: "Elise_tmjg2f.jpg", content_type: "image/jpg")
elise.save


puts "creation de profiles"

Tommy.profiles.create!(nickname: "Liam", birth_date: "2012-01-01", category: Category.all.sample)
Boby.profiles.create!(nickname: "Lou", birth_date: "2016-01-01", category: Category.all.sample)

file_lucia = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686232473/development/pixy/lucia_gsaugx.jpg")
lucia = Profile.new(
  nickname: 'Lucia',
  birth_date: '2010-01-14',
  category: Category.find_by(name: 'Faible'),
  user_id: elise.id
)
lucia.picture.attach(io: file_lucia, filename: "lucia_gsaugx.jpg", content_type: "image/jpeg")
lucia.save

file_bianca = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686235689/development/pixy/bianca2_dvutby.jpg")
bianca = Profile.new(
  nickname: 'Bianca',
  birth_date: '2012-12-23',
  category: Category.find_by(name: 'Modéré'),
  user_id: elise.id
)
bianca.picture.attach(io: file_bianca, filename: "Bianca_oyasse.jpg", content_type: "image/jpeg")
bianca.save

file_lilia = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686235697/development/pixy/lilia_q2zbmd.jpg")
lilia = Profile.new(
  nickname: 'Lilia',
  birth_date: '2016-07-05',
  category: Category.find_by(name: 'Elevé'),
  user_id: elise.id
)
lilia.picture.attach(io: file_lilia, filename: "lilia_q2zbmd.jpg", content_type: "image/jpeg")
lilia.save
