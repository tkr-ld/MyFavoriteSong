class AddTrackorderToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :trackorder, :integer
  end
end
