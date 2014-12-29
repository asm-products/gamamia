# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Game.create!(title:  		"Example Game",
             thumbnail: 	"http://placehold.it/150x150",
             description:   "Example description of a game, which would include a short summary of what this is all about",
             status: 		"released",
             link: 			"http://example.com",
             platform: 		"Xbox",
             votes: 		0)

99.times do |n|
  title  = Faker::App.name
  description = Faker::Lorem.sentence
  status = ["released", "beta"].sample
  platform = ["Xbox", "Playstation", "PC"].sample
  Game.create!(title:  		title,
             thumbnail: 	"http://placehold.it/150x150",
             description:   description,
             status: 		status,
             link: 			"http://example.com",
             platform: 		platform,
             votes: 		0)
end