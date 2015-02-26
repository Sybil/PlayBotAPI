class TracksController < ApplicationController
  def filters( *filters )
    filters.each do | filter |
      if param = params[filter] || params["#{filter}_id"]
        @tracks = @tracks.send( "with_#{filter}", param )
      end
    end
  end

  def filterCondition ( filters )
    query = ""
    filters.each do | filter |
      if param = params[filter] #|| params["#{filter}_id"]
        unless query.empty?
          query.concat(" and")
        end

        case filter
        when :tag, :channel, :user
          query.concat" #{filter}s.name='#{param}'"
        when :date
          query.concat(" irc_posts.posted_at='#{param}'")
        end
      end
    end
    return query
  end

  def filterQuery ( filters )
    query=""

    if [:channel, :user, :date].any? {|param| params.has_key? param}
      query.concat(" inner join irc_posts ON irc_posts.track_id = tracks.id")
    end

    filters.each do | filter |
      if params[filter] || params["#{filter}_id"]
        case filter
        when :channel
          query.concat(" inner join channels on irc_posts.channel_id = channels.id")
        when :user
          query.concat(" inner join users on irc_posts.user_id = users.id")
        when :tag
          query.concat(" inner join tag_assignations on tag_assignations.track_id = tracks.id inner join tags on tags.id = tag_assignations.tag_id")
        end
      end
    end
    return query
  end

  def filtersOptimized( *filters )
    condition = filterCondition( filters )
    query = filterQuery( filters )
    @tracks = Track.joins(query).where(condition).page params[:page]
  end

  def index
    #@tracks = Track.includes(:tags).page params[:page]
    #filters :tag, :channel, :user
    filtersOptimized :tag, :channel, :user, :date
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
