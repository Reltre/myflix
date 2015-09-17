Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs(2) }
end
