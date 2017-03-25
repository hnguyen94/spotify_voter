class TracksController < ApplicationController
  def index
    if !params[:tracks_name].empty?
      @tracks = RSpotify::Track.search(params[:tracks_name])
    else
      redirect_to root_path
    end
  end


  def update
    @track_to_edit = Track.find_by(spotify_id: params[:track_id])
    Track.update(@track_to_edit.spotify_id, :votings => 1)
  end


  def create
    @track = RSpotify::Track.find(params[:track_id])
    @track_to_add = Track.new({ :spotify_id => @track.id,
                                :name => @track.name,
                                :votings => 0,
                                :played_times => 0})
    if @track_to_add.save
      redirect_to root_path, notice: "Track was added!"
    end
  end


end
