Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs(2).join(" ") }
  small_cover { File.open(File.join(Rails.root,"public/tmp/test_small.jpg")) }
  large_cover { File.open(File.join(Rails.root,"public/tmp/test_small.jpg")) }
end
