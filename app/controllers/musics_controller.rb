class MusicsController < ApplicationController
  def filters( *filters )
    filters.each do | filter |
      if param = params[filter] || params["#{filter}_id"]
        @musics = @musics.send( "with_#{filter}", param )
      end
    end
  end

  def index
    @musics = Music.all
    filters :tag, :channel, :user
  
    render json: @musics, status: 200
  end

  def show 
    @music = Music.find(params[:id])
    
    render json: @music, status: 200
  end

end
