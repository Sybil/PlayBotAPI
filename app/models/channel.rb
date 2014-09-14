class Channel < ActiveRecord::Base
  self.table_name = "playbot_chan"

  belongs_to :music
end
