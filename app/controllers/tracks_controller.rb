class TracksController < ApplicationController
  def filters( *filters )
    filters.each do | filter |
      if param = params[filter] || params["#{filter}_id"]
        @tracks = @tracks.send( "with_#{filter}", param )
      end
    end
  end

  def index
    #@tracks = Track.includes(irc_posts: [:channel, :user], tag_assignations: :tag).all #includes(irc_posts: [{ :channels, :users}]) #includes(:channels,:tags,:users)
    #t = Track.all.joins('inner join irc_posts i ON tracks.track_id = i.track_id inner join channels c on i.channel_id = c.channel_id inner join gnations ti on tracks.track_id = ti.track_id inner join tags ta on ta.tag_id = ti.tag_id').select('tracks.name as t_name, u.name as u_name, c.name as c_name, ta.name as t_name')
    #t.first.c_name
    @tracks = Track.includes(:tags).page params[:page]
    filters :tag, :channel, :user
    render json: @tracks, 
      status: 200, 
      meta: {
        current_page: @tracks.current_page,
        per_page: @tracks.default_per_page,
        total_pages: @tracks.num_pages
      } 
  end

  def show 
    @track = Track.find(params[:id])
    
    render json: @track, status: 200
  end

end
