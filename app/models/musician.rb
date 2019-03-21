class Musician < ApplicationRecord
  mount_uploader :image, ImagesUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :detail, presence: true, length: { maximum: 200 }
    
  def self.search(search)
    if search
      Musician.where(['name LIKE ?', "%#{search}%"])
    else
      Musician.all
    end
  end
  
  def self.counts
    self.setlists.count
  end
  
  has_many :setlists, dependent: :destroy
  has_many :musician_relationships
  has_many :favoriting_users, through: :musician_relationships, source: :user
  
end
