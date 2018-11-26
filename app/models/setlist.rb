class Setlist < ApplicationRecord
  belongs_to :user
  belongs_to :musician
  has_many :songs
  has_many :musician_relationships
  has_many :joinusers, through: :setlist_relationships, source: :user
  
  accepts_nested_attributes_for :songs
  
  validates :title, presence: true, length: { maximum: 100 }
end
