# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'destruction de tous les lieux'
Place.destroy_all
puts 'destruction de tous les utilisateurs'
User.destroy_all

puts 'creation dun utilisateurs test'
user = User.find_or_create_by!(email: "lol@lol.com") do |u|
  u.password = "123456"
  u.name = "Test User"
end
puts 'creation dune categorie lieu'
category = Category.find_or_create_by!(name: "Lieu")

puts 'creation de 3 lieux'
[
  {
    title: "Parc de la Tête d'Or",
    content: "Le plus grand parc de Lyon, avec un zoo gratuit et un lac.",
    latitude: 45.7773,
    longitude: 4.8559
  },
  {
    title: "Vieux-Lyon",
    content: "Quartier Renaissance classé au patrimoine mondial de l'UNESCO.",
    latitude: 45.7627,
    longitude: 4.8274
  },
  {
    title: "Fourvière",
    content: "La colline qui prie, avec sa basilique et une vue panoramique sur Lyon.",
    latitude: 45.7622,
    longitude: 4.8220
  }
].each do |attrs|
  Place.find_or_create_by!(title: attrs[:title]) do |p|
    p.content = attrs[:content]
    p.latitude = attrs[:latitude]
    p.longitude = attrs[:longitude]
    p.user = user
    p.category = category
  end
end
