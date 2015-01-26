Fabricator(:comment) do
  content { Faker::Lorem.sentence }
  user
  game
end
