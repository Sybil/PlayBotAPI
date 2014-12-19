class ChannelsController < ApplicationController
  def index_users
    get_users()
    render json: @users, status: 200
  end

  def index
    get_channels()
    render json: @channels, status: 200
  end

  def show_user
    @tracks = Track.joins(:channel).where(playbot_chan: {sender_irc: params[:user]})
    render json: @user, status: 200
  end

  def show_channel
    @tracks = Track.joins(:channel).where(playbot_chan: {chan: "#"+params[:channel]})
    render json: @channel, status:200
  end

end
