
Track.delete_all
playlist = RSpotify::Playlist.find(ENV['playlist_user'],ENV['playlist_id'])
playlist.tracks.each do |track|
  puts track.name
  track_to_add = Track.new({ :spotify_id => track.id,
                    :name => track.name,
                    :votings => 0,
                    :played_times => 0 })
  track_to_add.save
end