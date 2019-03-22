class Song < ApplicationRecord
  belongs_to :setlist

  validates :trackorder, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validate :unique_in_setlist

  private

  #同じセットリスト内での曲順の重複を禁止
  def unique_in_setlist
    setlist_id = self.setlist_id
    setlist = Setlist.find(setlist_id)
    songs = setlist.songs.all
    songs.each do |s|
      if s.trackorder == self.trackorder
        errors.add(:trackorder, "は重複しないようにしてください")
        return
      end
    end
  end
  
end
