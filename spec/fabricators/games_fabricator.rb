Fabricator(:game) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
  status { Game::STATUS_TYPES.sample.last }
  link { Faker::Internet.url}
  scheduled_at { Date.yesterday }
  user

  after_create do |game, transients|
    2.times.map { Fabricate(:video, game: game) }
  end
end
