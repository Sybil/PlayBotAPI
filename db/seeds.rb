Track.delete_all
User.delete_all
Channel.delete_all
TagAssignation.delete_all
IrcPost.delete_all

OldDatabase::Playbot.find_each(batch_size: 1000) do |playbot|
  Track.create(id: playbot.id, name: playbot.title, provider: playbot.type, url: playbot.url)
end
p 'Tracks loading done'

OldDatabase::PlaybotChan.find_each(batch_size: 1000) do |p_chan|
  track = Track.find(p_chan.content)
  if track.author.blank?
    track.update(author: p_chan.sender_irc, channel: p_chan.chan)
  end

  user = User.find_or_create_by(name: p_chan.sender_irc)
  user.increment!(:quantity)
  channel = Channel.find_or_create_by(name: p_chan.chan)
  channel.increment!(:quantity)

  IrcPost.create(track_id: track.id, channel_id: channel.id, user_id: user.id, posted_at: p_chan.date)
end
p 'Irc posts loading done'

OldDatabase::PlaybotTag.all.each do |p_tag|
  tag = Tag.find_or_create_by(name: p_tag.tag)
  tag.increment!(:quantity)
  TagAssignation.create(track_id: p_tag.id, tag_id: tag.id)
end
p 'Tags loading done'

#alter table playbot_chan convert to character set utf8 collate utf8_general_ci;
ActiveRecord::Base.connection.execute("OPTIMIZE TABLE tracks, tags, channels, users, tag_assignations, irc_posts")
