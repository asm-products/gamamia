# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(email:         "admin@example.com",
             password:      "password",
             name:          "Joe Smith",
             username: "joe-smith",
             occupation:    "Developer",
             is_admin: true)

User.create!(email:         "admin@email.com",
             password:      "foobarfoo",
             name:          "Joe Smith",
             username: "joe-smith2",
             occupation:    "admin",
             is_admin: true)

Game.create!(title:          "Example Game",
            description:    "Example description of a game, which would include a short summary of what this is all about",
            status:         "released",
            link:           "http://example.com",
            votes:          0,
            user: admin)

Comment.create!(content:    "Example comment, which would reference a game somewhere",
            user_id:        1,
            game_id:        1)

Video.create!(
            title:          "Game",
            thumbnail:       "http://placehold.it/150x150",
            category:        "Trailer",
            embed:          "https://www.youtube.com/watch?v=9ZyQK6kUdWQ",
            game_id:        1)

99.times do |n|
  title  = Faker::App.name
  description = Faker::Lorem.sentence
  status = ["released", "beta"].sample
  platform = ["Xbox", "Playstation", "PC"].sample
  votes = rand(1..15)
  created_at = Faker::Time.between(7.days.ago, Time.now)

  email = Faker::Internet.email
  name = Faker::Name.name
  occupation = ["Developer", "Gamer", "Publisher"].sample

  user = User.create!(
    email:      email,
    password:   "foobarfoo",
    name:       name,
    username: "user-#{n}",
    occupation: occupation
  )

  Game.create!(title:       title,
             description:   description,
             status:        status,
             link:          "http://example.com",
             votes:         votes,
             created_at:    created_at,
             updated_at:    created_at,
             user:          user,
             scheduled_at:  rand(4).weeks.from_now)
end

199.times do |n|
  comment = Faker::Lorem.paragraph
  user_id = rand(1..100)
  game_id = rand(1..100)
  title = Faker::App.name
  category = ["Trailer", "Let's Play", "Twitch Stream"].sample

  Comment.create!(content:    comment,
              user_id:        user_id,
              game_id:        game_id)

  Video.create!(
              title:          title,
              thumbnail:       "http://placehold.it/150x150",
              category:       category,
              embed:          "https://www.youtube.com/watch?v=9ZyQK6kUdWQ",
              game_id:        game_id)
end

Game.find_each do |game|
  game.thumbnail = File.open(Dir.glob(File.join(Rails.root, 'app', 'assets', 'images', 'test', '*')).sample)
  game.comments_count = game.comments.count
  game.videos_count = game.videos.count
  game.save!
end
