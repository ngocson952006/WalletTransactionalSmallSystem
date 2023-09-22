# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create initial data
support_user = User.create!(username: 'support_user', password: 'support_user', email: 'support_user@example.com')
support_team = Team.create!(name: 'Support Team', login_user: support_user)

login_user = User.create!(username: 'team_loginuser', password: 'team_loginuser', email: 'team_loginuser@example.com')
team = Team.create!(name: 'Team1', login_user: login_user)

user = User.create!(username: 'user1', password: 'user1', email: 'user1@example.com', team_id: team.reload.id)

# Create initial wallet
support_wallet = Wallet.create!(ownerable_id: support_team.reload.id, ownerable_type: 'Team', balance: 1000)
team_wallet = Wallet.create!(ownerable_id: team.id, ownerable_type: 'Team', balance: 10)
user_wallet = Wallet.create!(ownerable_id: user.reload.id, ownerable_type: 'User', balance: 10)

# Default transactions, I assume these transactions are the first transactions to initial wallets balance
Transaction.create!(source_wallet_id: support_wallet.reload.id,
                   target_wallet_id: user_wallet.id,
                   amount: 10,
                   description: 'Default transaction',
                   status: :successful,
                   transaction_type: :transfer)

Transaction.create!(source_wallet_id: support_wallet.reload.id,
                   target_wallet_id: team_wallet.id,
                   amount: 10,
                   description: 'Default transaction',
                   status: :successful,
                   transaction_type: :transfer)
