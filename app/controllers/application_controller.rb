class ApplicationController < ActionController::API
  include ActionController::Serialization

  before_filter :get_tags, :get_users, :get_channels

  def get_channels
    channels = Channel.all    
    @channels = Array.new
    channels.each do |channel|
      if @channels.include?(channel.chan) == false
        @channels.push(channel.chan)
      end
    end
  end
  

  def get_tags
    tags = Tag.all

    @tags = Hash.new
    tags.each do |tag|
      @tags[tag.tag] ||= 0.0
      @tags[tag.tag] += 1.0
    end
    max_weight = @tags.values.max
    @tags.each do |tag, occ|
      if occ == 1
        @tags.delete(tag)
      else
        @tags[tag] = occ / max_weight
      end
    end
  end

  def get_users
    users = Channel.all

    @users = Hash.new
    users.each do |user|
      @users[user.sender_irc] ||= 0.0
      @users[user.sender_irc] += 1.0
    end

    max_weight = @users.values.max
    @users.each do |user, occ|
        @users[user] = occ / max_weight
    end
  end

end
