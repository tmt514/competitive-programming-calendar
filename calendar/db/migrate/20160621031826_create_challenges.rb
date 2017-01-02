class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.belongs_to :user, index: true
      t.belongs_to :entry, index: true
      t.string     :oj
      t.string     :pid
      t.string     :title
      t.integer    :points

      t.timestamps null: false
    end
  end
end
