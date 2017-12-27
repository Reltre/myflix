# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create!(name:'Comedies')
drama = Category.create!(name:'Dramas')
action = Category.create!(name:'Action')


if Rails.env == "development" || Rails.env == "test"
  Video.create!(title:'South Park',description: "going down to...", small_cover: File.new("#{Rails.root}/public/tmp/south_park.jpg"), large_cover: File.new("#{Rails.root}/public/tmp/test_large.jpg"), category: comedy, url: ENV['SAMPLE_VIDEO'])
  Video.create!(title:'Family Guy',description: "family fun", small_cover: File.new("#{Rails.root}/public/tmp/family_guy.jpg"), large_cover: File.new("#{Rails.root}/public/tmp/test_large.jpg"), category: comedy, url: ENV['SAMPLE_VIDEO'])
  Video.create!(title:'Monk',description: "detective", small_cover: File.new("#{Rails.root}/public/tmp/monk.jpg"), large_cover: File.new("#{Rails.root}/public/tmp/monk_large.jpg"), category: drama)
  futurama = Video.create!(title:'Futurama',description: "year 3000", small_cover: File.new("#{Rails.root}/public/tmp/futurama.jpg"), large_cover: File.new("#{Rails.root}/public/tmp/test_large.jpg"), category: comedy, url: ENV['SAMPLE_VIDEO'])
else
  Video.create!(title: "The Disaster Artist | Official Trailer HD | A24", description: "The first trailer for the movie, \"The Disaster Art...", created_at: "2017-12-01 21:11:32", updated_at: "2017-12-01 21:43:38", category: comedy, small_cover: "RackMultipart20171201-9-1d6snni.jpeg", large_cover: "RackMultipart20171201-9-1gwx5ye.jpg", url: "https://www.youtube.com/embed/cMKX2tE5Luk")
  john_wick = Video.create!(title: "John Wick: Chapter 2 - First Trailer", description: "John Wick chapter 2. One man gets revenge for his ...", created_at: "2017-12-20 03:34:47", updated_at: "2017-12-20 03:34:47", category: action, small_cover: "RackMultipart20171220-6-yson50.jpeg", large_cover: "RackMultipart20171220-6-17xdcdb.jpeg", url: "https://www.youtube.com/embed/ChpLV9AMqm4")
  big_short = Video.create!(title: "The Big Short - First Trailer", description: "A movie about the 2007/2008 financial crisis, and ...", created_at: "2017-12-26 22:00:40", updated_at: "2017-12-26 22:23:30", category: drama, small_cover: "RackMultipart20171226-9-1ayrxhp.jpeg", large_cover: "RackMultipart20171226-9-1d07rm1.jpeg", url: "https://www.youtube.com/embed/LWr8hbUkG9s")
end

dave = User.create!(email: "dave_bellevue@example.com" , password: "pw", full_name: "Dave Bellevue", admin: true)
cat = User.create!(email: "bojangles@gmail.com", password: "pw", full_name: "Mr. Bigglesworth", admin: false)
pikachu = User.create!(email: "pokemonOK@example.com", password: "pw", full_name: "Pokémon!", admin: false)

Relationship.create!(leader: dave, follower: cat)
Relationship.create!(leader: pikachu, follower: cat)


if Rails.env == "development" || Rails.env == "test"
  Review.create!(rating: 5,
                 content: "The best animated show that was on television.",
                 video: futurama,
                 user: pikachu)
  Review.create!(rating: 3,
                 content: "Such a good show, I wish they would bring it back.",
                 video: futurama,
                 user: cat)
else
  Review.create!(rating: 5,
                 content: "Such a good action movie, this trailer doesn't do it justice.",
                 video: john_wick ,
                 user: pikachu)
  Review.create!(rating: 4,
                 content: "This was a really informative movie. This trailer does a good job capturing the core aspects of the movie.",
                 video: big_short,
                 user: cat)
end
