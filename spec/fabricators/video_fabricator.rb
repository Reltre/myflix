Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs(2) }
  small_cover_url { "/tmp/futurama.jpg" }
end
