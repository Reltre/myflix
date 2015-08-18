# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(title:'Family Guy',small_cover_url: '/public/family_guy.jpg')
Video.create(title:'Monk', small_cover_url: '/public/monk.jpg')
Video.create(title:'South Park', small_cover_url: '/public/south_park.jpg')
Video.create(title:'Futurama', small_cover_url: '/public/futurama.jpg')
