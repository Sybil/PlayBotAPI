class MusicsController < ApplicationController
  def filters( *filters )
    filters.each do | filter |
      if param = params[filter] || params["#{filter}_id"]
        @musics = @musics.send( "with_#{filter}", param )
      end
    end
  end

  def index
    @musics = Music.page params[:page]
    filters :tag, :channel, :user
  
    respond_to do |format|
      format.json {render json: musics, status: 200}
    end
  end

  def show 
    @music = Music.find(params[:id])
    respond_to do |format|
      format.json {render json: music, status: 200}
    end
  end

end
