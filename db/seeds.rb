# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.create!({name: "User", email: "user@gmail.com", password: "password"})
board1 = Board.create!(name: "Dinosaurs", user_id: 1)
design1= Design.create!(board_id: board1.id, spoonflower_id: 2365210)
design2= Design.create!(board_id: board1.id, spoonflower_id: 2370443)
design3= Design.create!(board_id: board1.id, spoonflower_id: 2625534)
design4= Design.create!(board_id: board1.id, spoonflower_id: 2360335)
design5= Design.create!(board_id: board1.id, spoonflower_id: 2952827)
design6= Design.create!(board_id: board1.id, spoonflower_id: 5144777)


cart1 = Cart.create!(user_id: user1.id)
