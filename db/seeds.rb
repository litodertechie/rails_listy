# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#create a user
u1 = User.new({email: "lito@gmail.com", password:"1111111", first_name: "Lito", username: "Litotechie"})
u1.save
#


#create a list
l1 = List.new({name: "My favourite books"})
l1.save
#

#assign list to user
l1.user = u1
l1.save
#