class TagsController < ApplicationController

  def index
    #tags = Tag.all

    #list_tags = Array.new
    #tags.each do |tag| 
    #  list_tags.push(tag.tag)
    #end

    #@tags = Hash.new
    #list_tags.each do |tag|
    #  if @tags.key?(tag)
    #    @tags[tag] += 1.0
    #  else
    #    @tags[tag] = 1.0
    #  end
    #end

    #max_weight = @tags.values.max
    #@tags.each do |tag, occ|
    #  if occ == 1
    #    @tags.delete(tag)
    #  else
    #    @tags[tag] = occ / max_weight
    #  end
    #end

    respond_to do |format|
      format.json {render json: tags, status: 200}
    end
  end

  def show
    @musics = Music.joins(:tags).where(playbot_tags: {tag: params[:tag]}).page params[:page]
    respond_to do |format|
      format.json {render json: tag, status: 200}
    end
  end
end
