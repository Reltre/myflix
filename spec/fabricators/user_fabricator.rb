Fabricator(:user) do
  email { Faker::internet.email }
  password { Faker::internet.password }
end
