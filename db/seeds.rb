# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(first_name: "Arnaud", last_name: "Jeanroch", email: "arnaud@jeanroch.fr", password: '123123' )
user.image.attach(io: File.open('/usr/src/my-app/test/fixtures/files/photo.jpg'),  filename: 'photo.jpg' , content_type: "image/jpg")
user.save!

user = User.new(first_name: "Thomas", last_name: "David", email: "thomas@david.es", password: '123456' )
user.image.attach(io: File.open('/usr/src/my-app/test/fixtures/files/photo.jpg'),  filename: 'photo.jpg' , content_type: "image/jpg")
user.save!

user = User.new(first_name: "Lesley", last_name: "Skousen", email: "lesley@skousen.com", password: 'password' )
user.image.attach(io: File.open('/usr/src/my-app/test/fixtures/files/photo.jpg'),  filename: 'photo.jpg' , content_type: "image/jpg")
user.save!

user = User.new(first_name: "Bill", last_name: "Gates", email: "bill@microsoft.com", password: 'fundation' )
user.image.attach(io: File.open('/usr/src/my-app/test/fixtures/files/photo.jpg'),  filename: 'photo.jpg' , content_type: "image/jpg")
user.save!

Request.create(title: "Dog Walking", user_id: 1, location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337,  description: "Please, walk my doggo", category: 'service')

Request.create(title: "Cat Sitting", user_id: 1, location: "London Bridge, Tower", latitude: 50.505484, longitude: -1.075337,  description: "Otherwise he will definitely eat the dog", category: 'service')

Request.create(title: "Commute me home", user_id: 2, location: "Tower London, Bridge", latitude: 51.505484, longitude: -1.075337,  description: "I'm stuck in the office with my boss", category: 'service')

Request.create(title: "Screwdriver", user_id: 2, location: "Bridge Tower, London", latitude: 50.505484, longitude: -0.075337,  description: "I need quite a small screwdriver, flat head", category: 'material')