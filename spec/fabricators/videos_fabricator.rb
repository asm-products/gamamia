Fabricator(:video) do
  title Faker::Name.name
  thumbnail Faker::Lorem.word
  category Faker::Lorem.word
  embed Faker::Lorem.sentence
end
