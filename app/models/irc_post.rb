class IrcPost < ActiveRecord::Base
  belongs_to :track
  belongs_to :user
  belongs_to :channel

end
