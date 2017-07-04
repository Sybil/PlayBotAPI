class Tag < ActiveRecord::Base
  has_many :tag_assignations
  has_many :tracks, through: :tag_assignation
end
