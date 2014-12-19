class Channel < ActiveRecord::Base
  self.table_name = "playbot_chan"
  belongs_to :track

  def self.with_channel(channel)
    where("chan = ?", channel)
  end

  def self.with_user(user)
    where("irc_sender = ?", user)
  end

end
