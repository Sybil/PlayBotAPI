class TracksController < ApplicationController
  def index
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
    filters.each do |filter|
      next unless params[filter] || params["#{filter}_id"]

      case filter
      when :channel
        tracks = tracks.joins(irc_posts: :channel)
      when :user
        tracks = tracks.joins(irc_posts: :user)
      end
    end

    tracks
  end

  def filtersOptimized(*filters)
    condition = filterCondition(filters)
    tracks = Track.joins(:tags)
    tracks = filterQuery(filters, tracks)

    tracks.where(condition).distinct
  end
end
