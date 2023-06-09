User.destroy_all
Category.destroy_all
Profile.destroy_all
Visit.destroy_all

puts "creation de categories"
Category.create(name: "Faible")
Category.create(name: "Modéré")
Category.create(name: "Elevé")


puts "creation de users"

tommy = User.create(email: "tommy@gmail.com", password: "123456", first_name: "Tommy", last_name: "Lam")
boby = User.create(email: "boby@gmail.com", password: "123456", first_name: "boby", last_name: "Lam")

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

boby.profiles.create!(nickname: "Lou", birth_date: "2016-01-01", category: Category.all.sample)

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


file_lou = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686235697/development/pixy/lilia_q2zbmd.jpg")
lou = Profile.new(
  nickname: 'L0u',
  birth_date: '2016-08-05',
  category: Category.find_by(name: 'Elevé'),
  user_id: tommy.id
)
lou.picture.attach(io: file_lou, filename: "lilia_q2zbmd.jpg", content_type: "image/jpg")
lou.save

file_lala = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686235697/development/pixy/lilia_q2zbmd.jpg")
lala = Profile.new(
  nickname: 'Lala',
  birth_date: '2012-08-05',
  category: Category.find_by(name: 'Modéré'),
  user_id: tommy.id
)
lala.picture.attach(io: file_lala, filename: "lilia_q2zbmd.jpg", content_type: "image/jpg")
lala.save


file_lili = URI.open("https://res.cloudinary.com/dmgpqeugv/image/upload/v1686235697/development/pixy/lilia_q2zbmd.jpg")
lili = Profile.new(
  nickname: 'Lili',
  birth_date: '2010-08-05',
  category: Category.find_by(name: 'Faible'),
  user_id: tommy.id
)
lili.picture.attach(io: file_lili, filename: "lilia_q2zbmd.jpg", content_type: "image/jpg")
lili.save
puts "creation de visits"

Visit.create(
  profile_id: lucia.id,
  title: "jeux video.com",
  url: 'https://www.jeuxvideo.com/forums/42-51-71450961-2-0-1-0-putain-je-me-branle-rarement-mais-quand-je-le-fais.htm',
  words_changed: 110,
  date: DateTime.now
)

Visit.create(
  profile_id: bianca.id,
  title: "wikipedia.org",
  url: 'https://fr.wikipedia.org/wiki/Su%C3%A8de',
  words_changed: 3,
  date: DateTime.now
)


Visit.create(
  profile_id: lilia.id,
  title: "vikidia.org",
  url: 'https://fr.vikidia.org/wiki/Lapin',
  words_changed: 0,
  date: DateTime.now
)

Visit.create(
  profile_id: lou.id,
  title: "vikidia.org",
  url: 'https://fr.vikidia.org/wiki/Lapin',
  words_changed: 0,
  date: DateTime.now
)

Visit.create(
  profile_id: lala.id,
  title: "vikidia.org",
  url: 'https://fr.vikidia.org/wiki/Lapin',
  words_changed: 0,
  date: DateTime.now
)

Visit.create(
  profile_id: lili.id,
  title: "jeux video.com",
  url: 'https://www.jeuxvideo.com/forums/42-51-71450961-2-0-1-0-putain-je-me-branle-rarement-mais-quand-je-le-fais.htm',
  words_changed: 110,
  date: DateTime.now
)
