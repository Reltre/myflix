Fabricator(:invitation) do
  email { Faker::Internet.email }
  token { "test12" }
  message { Faker::Lorem.paragraph(2) }
end
