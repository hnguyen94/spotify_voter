class PlaylistsController < ApplicationController
  def show
    @playlist = RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id'])
  end
end
