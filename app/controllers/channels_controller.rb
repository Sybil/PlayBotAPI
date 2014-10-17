class ChannelsController < ApplicationController
  def index_users
    get_users()

    respond_to do |format|
      format.html
    end
  end

  def index
    get_channels()
   
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
