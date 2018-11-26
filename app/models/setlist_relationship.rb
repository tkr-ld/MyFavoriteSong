class SetlistRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :setlist
end
