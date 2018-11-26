class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :setlists
  has_many :musician_relationships
  has_many :favorites, through: :musician_relationships, source: :musician
  has_many :setlist_relationships
  has_many :joinlives, through: :setlist_relationships, source: :setlist
  
  def favorite(musician1)
      self.musician_relationships.find_or_create_by(musician_id: musician1.id)
  end
    
  def unfavorite(musician1)
      relationship = self.musician_relationships.find_by(musician_id: musician1.id)
      relationship.destroy if relationship
  end
    
  def favoriting?(musician1)
      self.favorites.include?(musician1)
  end
  
  def join(setlist1)
      self.setlist_relationships.find_or_create_by(setlist_id: setlist1.id)
  end
    
  def unjoin(setlist1)
      relationship = self.setlist_relationships.find_by(setlist_id: setlist1.id)
      relationship.destroy if relationship
  end
    
  def joinning?(setlist1)
      self.joinlives.include?(setlist1)
  end
end
