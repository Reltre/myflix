Fabricator(:review) do
  rating { Faker::Number.between(1, 5) }
  description { Faker::Lorem.paragraph(2) }
end
