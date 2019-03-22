class RemoveOrderFromSongs < ActiveRecord::Migration[5.0]
  def change
    remove_column :songs, :order, :integer
  end
end
