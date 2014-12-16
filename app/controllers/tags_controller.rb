class TagsController < ApplicationController

  def index
    render json: @tags, status: 200
  end

  def show
    @musics = Music.joins(:tags).where(playbot_tags: {tag: params[:tag]})
    render json: @tag, status: 200
  end
end
