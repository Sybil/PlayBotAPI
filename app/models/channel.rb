class Channel < ActiveRecord::Base
  has_many :irc_posts
  has_many :tracks, through: :irc_posts

  def self.with_channel(channel)
    where("name = ?", channel)
  end
end
