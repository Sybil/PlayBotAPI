class TagsController < ApplicationController

  def index
    @tags = Tag.all.order(quantity: :desc)
    render json: @tags, status: 200
  end

end
