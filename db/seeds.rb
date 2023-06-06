Category.destroy_all
puts "creation de categories"
Category.create(name: "Low")
Category.create(name: "Medium")
Category.create(name: "Hight")

# low = Category.find_by(name: "Low")
# medium = Category.find_by(name: "Medium")
# hight = Category.find_by(name: "Hight")
User.destroy_all

puts "creation de users"

Tommy = User.create(email: "tommy@gmail.com", password: "123456", first_name: "Tommy", last_name: "Lam")
Elise = User.create(email: "Elise@gmail.com", password: "123456", first_name: "Elise", last_name: "Lam")
Boby = User.create(email: "boby@gmail.com", password: "123456", first_name: "boby", last_name: "Lam")


puts "creation de profiles"

Tommy.profiles.create!(nickame: "Tommy", birth_date: "2000-01-01", category: Category.all.sample)
Elise.profiles.create!(nickame: "Elise", birth_date: "2001-01-01", category: Category.all.sample)
Boby.profiles.create!(nickame: "boby", birth_date: "2002-01-01", category: Category.all.sample)
