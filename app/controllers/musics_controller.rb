class MusicsController < ApplicationController
  def add_filters(filters)

    @musics = @musics.with_tag(filters[:tag_id]) if filters.has_key?(:tag_id)
    @musics = @musics.with_channel('#'+filters[:channel_id]) if filters.has_key?(:channel_id)
    @musics = @musics.with_user(filters[:user_id]) if filters.has_key?(:user_id)
  end
  
  def index
    @musics = Music.page params[:page]
    add_filters(params)

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

end
