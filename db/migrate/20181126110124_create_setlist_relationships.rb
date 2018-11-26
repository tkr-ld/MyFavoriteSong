class CreateSetlistRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :setlist_relationships do |t|
      t.references :user, foreign_key: true
      t.references :setlist, foreign_key: true

      t.timestamps
    end
  end
end
