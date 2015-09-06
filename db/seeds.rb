# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create!(name:'TV Comedies')
drama = Category.create!(name:'TV Dramas')
Category.create!(name:'Reality TV')

Video.create!(title:'South Park',description: "going down to...", small_cover_url: '/tmp/south_park.jpg', category: comedy)
Video.create!(title:'Family Guy',description: "family fun", small_cover_url: '/tmp/family_guy.jpg', category: comedy)
Video.create!(title:'Monk',description: "detective", small_cover_url: '/tmp/monk.jpg', category: drama)
Video.create!(title:'South Park',description: "going down to...", small_cover_url: '/tmp/south_park.jpg', category: comedy)
Video.create!(title:'Futurama',description: "year 3000", small_cover_url: '/tmp/futurama.jpg', category: comedy)


Video.create!(title:'Monk',description: "detective", small_cover_url: '/tmp/monk.jpg', category: drama)
Video.create!(title:'Futurama',description: "year 3000", small_cover_url: '/tmp/futurama.jpg', category: comedy)
Video.create!(title:'South Park',description: "going down to...", small_cover_url: '/tmp/south_park.jpg', category: comedy)
Video.create!(title:'Family Guy',description: "family fun",small_cover_url: '/tmp/family_guy.jpg', category: comedy)
