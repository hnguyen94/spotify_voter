class PlaylistsController < ApplicationController
  def index
  end

  def show
    @playlist = RSpotify::Playlist.find('mibr7','5V2YrcPuEPxVPdI0QDoLJx')
  end
end
