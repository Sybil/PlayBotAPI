class MusicsController < ApplicationController
  def index
    @musics = Music.page params[:page]

    respond_to do |format|
      format.html
    end
  end

  def show 
    @music = Music.find(params[:id])
    respond_to do |format|
      format.html {render 'show', layout: false}
    end
  end

  def filters
    @musics = Music.joins(:tags).where(playbot_tags: {tag: params[:tag]}).joins(:channel).where(playbot_chan: {chan: params[:channel]}).where(playbot_chan: {sender_irc: params[:user]}).page params[:page]
    respond_to do |format|
      format.html
    end
  end
# where(playbot_tags: {tag: params[:tag]})


end
