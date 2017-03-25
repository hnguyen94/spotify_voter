class PlaylistsController < ApplicationController
  def index
  end

  def show
    @playlist = RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id'])
  end
end
