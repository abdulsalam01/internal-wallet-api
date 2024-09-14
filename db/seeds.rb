# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# db/seeds.rb

Wallet.create(name: 'User 1', balance: 1000.00)
Wallet.create(name: 'User 2', balance: 2000.00)
Wallet.create(name: 'Team 1', balance: 1500.00)
Wallet.create(name: 'Team 2', balance: 1800.00)

puts 'Wallets seeded successfully.'
