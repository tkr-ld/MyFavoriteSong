class Song < ApplicationRecord
  validates :trackorder, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  
  belongs_to :setlist
end
