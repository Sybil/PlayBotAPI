class ChannelsController < ApplicationController

  def index
    channels = Channel.all.order(quantity: :desc)
    render json: channels, status: 200
  end
end
