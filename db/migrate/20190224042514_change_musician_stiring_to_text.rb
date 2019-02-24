class ChangeMusicianStiringToText < ActiveRecord::Migration[5.0]
  def up
    change_column :musicians, :detail, :text
  end

  def down
    change_column :musicians, :detail, :string
  end
end