class ChannelsController < ApplicationController
  def index_users
    users = Channel.all

    list_users = Array.new
    users.each do |user| 
      list_users.push(user.sender_irc)
    end

    @usercloud = Hash.new
    list_users.each do |user|
      if @usercloud.key?(user)
        @usercloud[user] += 1.0
      else
        @usercloud[user] = 1.0
      end
    end

    max_weight = @usercloud.values.max
    @usercloud.each do |user, occ|
        @usercloud[user] = occ / max_weight
    end

    respond_to do |format|
      format.html
    end
  end

  def index
    channels = Channel.all
    list_channels = Array.new
    channels.each do |channel| 
      list_channels.push(channel.chan)
    end

    @channels = Array.new
    list_channels.each do |channel|
      if @channels.include?(channel) == false
        @channels.push(channel)
      end
    end
   
    respond_to do |format|
      format.html
    end 
  end

  def show_user
    @musics = Music.joins(:channel).where(playbot_chan: {sender_irc: params[:user]}).page params[:page]
    respond_to do |format|
      format.html
    end
  end

  def show_channel
    @musics = Music.joins(:channel).where(playbot_chan: {chan: "#"+params[:channel]}).page params[:page]
    respond_to do |format|
      format.html
    end
  end
end
