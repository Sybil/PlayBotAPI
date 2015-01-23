class TagsController < ApplicationController

  def index
    render json: @tags, status: 200
  end

end
