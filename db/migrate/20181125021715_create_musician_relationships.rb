class CreateMusicianRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :musician_relationships do |t|
      t.references :user, foreign_key: true
      t.references :musician, foreign_key: true

      t.timestamps
    end
  end
end
