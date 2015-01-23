class ChannelsController < ApplicationController

  def index
    render json: @channels, status: 200
  end
end
