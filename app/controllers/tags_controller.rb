class TagsController < ApplicationController

  def index
    @tags = Tag.all.order(quantity: :desc)
    render json: @tags, status: 200
  end

  def tagsFilter
    @tags = Tag.limit(100).order(quantity: :desc)
    render json: @tags, status: 200
  end

end
