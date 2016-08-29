class CreateChallengestatuses < ActiveRecord::Migration
  def change
    create_table :challengestatuses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :challenge, index: true
      t.string     :status

      t.timestamps null: false
    end
  end
end
