class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :user, index: true
      t.string :calendarid
      t.datetime :target, index: true
      t.string :message
      t.string :status
      t.string :url

      t.timestamps null: false
    end
  end
end
