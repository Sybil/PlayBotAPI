class User < ActiveRecord::Base
 
  has_many :irc_posts
  has_many :tracks, through: :irc_posts

  def self.with_user(user)
    where("name = ?", user)
  end

end
