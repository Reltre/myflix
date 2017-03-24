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

Video.create!(title:'South Park',description: "going down to...", small_cover: '/tmp/south_park.jpg', category: comedy)
Video.create!(title:'Family Guy',description: "family fun", small_cover: '/tmp/family_guy.jpg', category: comedy)
Video.create!(title:'Monk',description: "detective", small_cover: '/tmp/monk.jpg', category: drama)
futurama = Video.create!(title:'Futurama',description: "year 3000", small_cover: '/tmp/futurama.jpg', category: comedy)


# Video.create!(title:'Monk',description: "detective", small_cover_url: '/tmp/monk.jpg', category: drama)
# Video.create!(title:'South Park',description: "going down to...", small_cover_url: '/tmp/south_park.jpg', category: comedy)
# Video.create!(title:'Family Guy',description: "family fun",small_cover_url: '/tmp/family_guy.jpg', category: comedy)
# futurama = Video.create!(title:'Futurama',description: "year 3000", small_cover_url: '/tmp/futurama.jpg', category: comedy)

dave = User.create!(email: "dave_bellevue@example.com" , password: "pw", full_name: "Dave Bellevue", admin: true)
cat = User.create!(email: "bojangles@gmail.com", password: "pw", full_name: "Mr. Bigglesworth", admin: false)
pikachu = User.create!(email: "pokemonOK@example.com", password: "pw", full_name: "Pokémon!", admin: false)

Relationship.create!(leader: dave, follower: cat)
Relationship.create!(leader: pikachu, follower: cat)

Review.create!(rating: 5,
               content: "so good, one of the best cartoon comedies",
               video: futurama,
               user: pikachu)
Review.create!(rating: 3,
               content: "It's ok I guess",
               video: futurama,
               user: cat)
