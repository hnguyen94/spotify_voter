class TracksController < ApplicationController
  def index
    if !params[:tracks_name].empty?
      @tracks = RSpotify::Track.search(params[:tracks_name])
    else
      redirect_to root_path
    end
  end
end
