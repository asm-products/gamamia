Fabricator(:game) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
  status { Game::STATUS_TYPES.sample.last }
  link { Faker::Internet.url}
  platform { Game::PLATFORM_TYPES.sample.last }
end

