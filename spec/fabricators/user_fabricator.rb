Fabricator(:user) do
  email { Faker::Internet.email }
  name { Faker::Name.name }
  username { Faker::Name.name.parameterize }
  occupation { Faker::Lorem.word }
  password "foobar123"
  password_confirmation "foobar123"
end

Fabricator(:admin_user, from: :user) do
  is_admin true
end
