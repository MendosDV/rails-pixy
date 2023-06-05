class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.string :url
      t.integer :words_changed
      t.datetime :date
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
