class TagsController < ApplicationController
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @musics = Music.joins(:tags).where(playbot_tags: {tag: params[:tag]}).page params[:page]
    respond_to do |format|
      format.html
    end
  end
end
