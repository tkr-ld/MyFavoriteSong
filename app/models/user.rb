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
  
  def favorite(musician)
      self.musician_relationships.find_or_create_by(musician_id: musician.id)
  end
    
  def unfavorite(musician)
      relationship = self.musician_relationships.find_by(musician_id: musician.id)
      relationship.destroy if relationship
  end
    
  def favoriting?(musician)
      self.favorites.include?(musician)
  end
  
  def join(setlist)
      self.setlist_relationships.find_or_create_by(setlist_id: setlist.id)
  end
    
  def unjoin(setlist)
      relationship = self.setlist_relationships.find_by(setlist_id: setlist.id)
      relationship.destroy if relationship
  end
    
  def joinning?(setlist)
      self.joinlives.include?(setlist)
  end
end
