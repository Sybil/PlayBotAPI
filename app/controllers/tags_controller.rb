class TagsController < ApplicationController

  def index
    tags = Tag.all

    list_tags = Array.new
    tags.each do |tag| 
      list_tags.push(tag.tag)
    end

    @tagcloud = Hash.new
    list_tags.each do |tag|
      if @tagcloud.key?(tag)
        @tagcloud[tag] += 1.0
      else
        @tagcloud[tag] = 1.0
      end
    end

    max_weight = @tagcloud.values.max
    @tagcloud.each do |tag, occ|
      @tagcloud[tag] = occ / max_weight
    end

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
