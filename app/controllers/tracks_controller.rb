class TracksController < ApplicationController
  def index
    #@tracks = Track.includes(:tags).page params[:page]
    #filters :tag, :channel, :user
    tracks = filtersOptimized(:tag, :channel, :user, :date).page(params[:page])
    render json: tracks,
      status: 200,
      include: :tags,
      meta: {
        current_page: tracks.current_page,
        per_page: tracks.default_per_page,
        total_pages: tracks.total_pages
      }
  end

  def show
    track = Track.find(params[:id])

    render json: track, status: 200
  end

  private

  def filters(*filters)
    filters.each do |filter|
      if param = params[filter] || params["#{filter}_id"]
        @tracks = @tracks.send( "with_#{filter}", param )
      end
    end
  end

  def filterCondition(filters)
    query = ""
    filters.each do |filter|
      param = params[filter]
      next if param.nil?

      query.concat(" and") unless query.empty?
      param = params[filter]

      case filter
      when :tag, :channel, :user
        query.concat(" #{filter}s.name='#{param}'")
      when :date
        query.concat(" date(irc_posts.posted_at)='#{param}'")
      end
    end

    query
  end

  def filterQuery(filters, tracks)
    #query=""

    #if [:channel, :user, :date].any? { |param| params.has_key? param }
      #tracks = tracks.joins(:irc_posts)
      #query.concat(" inner join irc_posts ON irc_posts.track_id = tracks.id")
    #end

    filters.each do |filter|
      next unless params[filter] || params["#{filter}_id"]

      case filter
      when :channel
        tracks = tracks.joins(irc_posts: :channels)
        #query.concat(" inner join channels on irc_posts.channel_id = channels.id")
      when :user
        tracks = tracks.joins(irc_posts: :users)
        #query.concat(" inner join users on irc_posts.user_id = users.id")
      when :tag
        #tracks = tracks
        #query.concat(" inner join tag_assignations on tag_assignations.track_id = tracks.id inner join tags on tags.id = tag_assignations.tag_id")
      end
    end

    #query
    tracks
  end

  def filtersOptimized(*filters)
    condition = filterCondition(filters)
    #query = filterQuery(filters, tracks)
    tracks = Track.includes(:tags)
    tracks = filterQuery(filters, tracks)

    if [:channel, :user, :date].any? { |param| params.has_key? param }
      #tracks = Track.joins(query).where(condition).group("tracks.id").page params[:page]
      tracks = tracks.where(condition).group("tracks.id")
    else
      #tracks = Track.joins(query).where(condition).page params[:page]
      tracks = tracks.where(condition)
    end

    tracks
  end
end
