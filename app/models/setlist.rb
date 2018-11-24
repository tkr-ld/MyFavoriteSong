class Setlist < ApplicationRecord
  belongs_to :user
  belongs_to :musician
  has_many :songs
  accepts_nested_attributes_for :songs
  
  validates :title, presence: true, length: { maximum: 100 }
end
