Fabricator(:review) do
  rating { Faker::Number.between(1, 5) }
  content { Faker::Lorem.paragraph(3) }
end
