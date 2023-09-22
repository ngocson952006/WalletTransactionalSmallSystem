class CreateTableTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :login_user, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
