Fabricator(:user) do
  email { Faker::Internet.email }
  name { Faker::Name.name }
  username { Faker::Name.name.parameterize }
  occupation { Faker::Lorem.word }
  password "foobar123"
  password_confirmation "foobar123"
  email_notifications true
end

Fabricator(:admin_user, from: :user) do
  role "admin"
end
