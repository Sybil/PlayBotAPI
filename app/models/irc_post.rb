class IrcPost < ActiveRecord::Base
  self.table_name = 'irc_posts'

  belongs_to :track
  belongs_to :user
  belongs_to :channel
end
