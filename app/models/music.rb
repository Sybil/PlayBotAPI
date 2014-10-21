class Music < ActiveRecord::Base
  self.table_name = "playbot"
  self.inheritance_column = "inheritance_type"

  has_many :tags, foreign_key: "id"
  has_one :channel, primary_key: "id", foreign_key: "content"

  def self.with_tag(tag)
      self.joins(:tags).where("tag = ?", tag )
  end

  def self.with_channel(channel)
    self.joins(:channel).where("channel = ?", "##{channel}")
  end

  def self.with_user(user)
    self.joins(:channel).where("playbot_chan.sender_irc = ?", user)
  end 

end
