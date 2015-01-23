class Track < ActiveRecord::Base
  paginates_per 50  
  #default_scope includes(:channels,:users,:tags)

  has_many :irc_posts
  has_many :tag_assignations

  has_many :tags, through: :tag_assignations
  has_many :channels, through: :irc_posts
  has_many :users, through: :irc_posts

  def self.with_tag(tag)
    self.joins(:tags).where("tags.name = ?", tag )
    #self.includes(:tags)
    #self.where("tag = ?", tag)
  end

  def self.with_channel(channel)
    self.joins(:channels).where("channels.name = ?", "##{channel}")
  end

  def self.with_user(user)
    self.joins(:users).where("users.name = ?", user)
  end 

end
