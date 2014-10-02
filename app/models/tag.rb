class Tag < ActiveRecord::Base
  self.table_name = "playbot_tags"
  belongs_to :music

  def self.with_tag(tag)
    where("tag = ?", tag)
  end

end
