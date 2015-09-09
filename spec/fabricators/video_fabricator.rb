Fabricator(:video) do
  title { Faker::lorem.word }
  description { Faker::lorem.sentence }
end
