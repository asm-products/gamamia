Fabricator(:comment) do
  content { Faker::Lorem.paragraph }
  user
  game
end
