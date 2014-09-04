class MusicsController < ApplicationController
  def index
    @musics = Music.page params[:page]

    respond_to do |format|
      format.html
    end
  end

  def show 
    @music = Music.find(params[:id])
    respond_to do |format|
      format.html {render 'show', layout: false}
    end
  end

end
