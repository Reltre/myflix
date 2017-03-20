Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs(2).join(" ") }
  category_id { 3 }
  small_cover { "/tmp/test_small.png" }
  large_cover { "/tmp/test_large.png" }
end
