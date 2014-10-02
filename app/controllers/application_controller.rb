class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_tags, :get_users, :get_channel

  def get_channel
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
      if @tags.key?(tag.tag)
        @tags[tag.tag] += 1.0
      else
        @tags[tag.tag] = 1.0
      end
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
      if @users.key?(user.sender_irc)
        @users[user.sender_irc] += 1.0
      else
        @users[user.sender_irc] = 1.0
      end
    end

    max_weight = @users.values.max
    @users.each do |user, occ|
        @users[user] = occ / max_weight
    end
  end

end
