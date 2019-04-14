class Setlist < ApplicationRecord
  belongs_to :user
  belongs_to :musician
  has_many :songs, dependent: :destroy
  has_many :musician_relationships
  has_many :joinusers, through: :setlist_relationships, source: :user
  
  accepts_nested_attributes_for :songs
  
  validates :title, presence: true, length: { maximum: 100 }

  def new_song_number
    max = 0
    songs.all.each do |song| 
      max = song.trackorder if song.trackorder > max
    end
    return max + 1
  end

end
