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
end
