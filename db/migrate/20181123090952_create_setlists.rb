class CreateSetlists < ActiveRecord::Migration[5.0]
  def change
    create_table :setlists do |t|
      t.references :user, foreign_key: true
      t.references :musician, foreign_key: true
      t.string :title
      t.date :date
      t.string :place

      t.timestamps
    end
  end
end
