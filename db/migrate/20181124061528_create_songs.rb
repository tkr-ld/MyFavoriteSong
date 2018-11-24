class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.references :setlist, foreign_key: true
      t.string :title
      t.integer :order

      t.timestamps
    end
  end
end
