class Tag < ActiveRecord::Base
  self.table_name = "playbot_tags"

  belongs_to :music
end
