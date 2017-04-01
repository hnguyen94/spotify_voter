require 'rest-client'
require 'json'
class TracksController < ApplicationController
  def index
    if !params[:tracks_name].empty?
      @tracks = RSpotify::Track.search(params[:tracks_name])
    else
      redirect_to root_path
    end
  end


  def update
    track_to_edit = Track.find_by(spotify_id: params[:id])
    track_to_edit.votings += 1
    track_to_edit.save

    tracks_ordered = Track.order_by(:played_times.desc,:votings.desc)
    track_ids = []
    tracks_ordered.each { |track| track_ids.push track.spotify_id }
    tracks_for_replace = RSpotify::Track.find(track_ids)


    RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id']).replace_tracks!(tracks_for_replace)

    @playlist = RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id'])

    render 'playlists/show'
  end


  def create
    @track = RSpotify::Track.find(params[:track_id])
    @track_to_add = Track.new({ :spotify_id => @track.id,
                                :votings => 0,
                                :played_times => 0})
    if @track_to_add.save
      RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id']).add_tracks!([@track])
      redirect_to root_path, notice: "Track was added!"
    end
  end

  def check_last_played_track
    url = 'https://api.spotify.com/v1/me/player/recently-played?limit=1'
    resource = RestClient::Resource.new(url, :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
    header_content_type = 'application/json'
    auth_tok = request.env['omniauth.auth'].credentials['token']
    response = resource.get({"Authorization" => auth_tok, "Accept" => header_content_type})
    response_json = JSON.parse(response.body)

    id = response_json['items'][0]['track']['id']

    track_to_edit = Track.find_by(spotify_id: id)

    unless track_to_edit.is_last_played
      puts 'id not equal!!'
      if Track.where(is_last_played: true).exists?
        last_played_track = Track.find_by(is_last_played: true)
        last_played_track.is_last_played = false
        last_played_track.save
      end

      track_to_edit.played_times += 1
      track_to_edit.is_last_played = true
      track_to_edit.save

      tracks_ordered = Track.order_by(:played_times.asc,:votings.desc)
      track_ids = []
      tracks_ordered.each { |track| track_ids.push track.spotify_id }
      tracks_for_replace = RSpotify::Track.find(track_ids)

      RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id']).replace_tracks!(tracks_for_replace)

    end

    @playlist = RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id'])

    render 'playlists/show'
  end



end

