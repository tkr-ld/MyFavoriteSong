class Setlist < ApplicationRecord
  belongs_to :user
  belongs_to :musician
  
  validates :title, presence: true, length: { maximum: 100 }
end
