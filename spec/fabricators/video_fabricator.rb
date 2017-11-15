Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs(2).join(" ") }
  small_cover { "test_small.jpg" }
  large_cover { "test_large.jpg" }
  url { "http://example.com" }
end
