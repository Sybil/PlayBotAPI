Track.delete_all
User.delete_all
Channel.delete_all
TagAssignation.delete_all
IrcPost.delete_all

OldDatabase::Playbot.find_each do |playbot|
  Track.create(id: playbot.id, name: playbot.title, provider: playbot.type, url: playbot.url)
end

OldDatabase::PlaybotChan.find_each do |p_chan|
  track = Track.find(p_chan.content)
  if track.author.blank?
    track.update(author: p_chan.sender_irc, channel: p_chan.chan)
  end

  user = User.find_or_create_by(name: p_chan.sender_irc)
  channel = Channel.find_or_create_by(name: p_chan.chan)

  IrcPost.create(track_id: track.id, channel_id: channel.id, user_id: user.id, posted_at: p_chan.date)
end

OldDatabase::PlaybotTag.all.each do |p_tag|
  tag = Tag.find_or_create_by(name: p_tag.tag)
  TagAssignation.create(track_id: p_tag.id, tag_id: tag.id)
end

#alter table playbot_chan convert to character set utf8 collate utf8_general_ci;

