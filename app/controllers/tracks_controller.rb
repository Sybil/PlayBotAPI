class TracksController < ApplicationController
  def filters( *filters )
    filters.each do | filter |
      if param = params[filter] || params["#{filter}_id"]
        @tracks = @tracks.send( "with_#{filter}", param )
      end
    end
  end

  def index
    @tracks = Track.includes(:channel, :tags)
    filters :tag, :channel, :user
    render json: @tracks, status: 200
  end

  def show 
    @track = Track.find(params[:id])
    
    render json: @track, status: 200
  end

end
