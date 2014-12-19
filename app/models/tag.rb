class Tag < ActiveRecord::Base
  self.table_name = :playbot_tags
  self.primary_keys = :id, :tag
  
  belongs_to :track

end
