class CreateUserprofiles < ActiveRecord::Migration
  def change
    create_table :userprofiles do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :value

      t.timestamps null: false
    end
  end
end
