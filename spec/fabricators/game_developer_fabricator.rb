Fabricator(:game_developer) do
  title { Faker::Lorem.word }
  location { Faker::Address.city }

  after_create { |dev| dev.thumbnail = File.open(File.join(Rails.root,'public','twitter.png')) }
end
