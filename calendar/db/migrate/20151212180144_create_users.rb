class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image
      t.string :token
      t.string :email
      t.datetime :expires_at

      t.string :role
      t.string :displayname

      t.timestamps null: false
    end
  end
end
