class TagsController < ApplicationController

  def index
    @tags = Tag.all.order(quantity: :desc)
    render json: @tags, status: 200
  end

  def tagsFilter
    @tags = Tag.limit(200).order(quantity: :desc)
    render json: @tags, status: 200
  end

end
