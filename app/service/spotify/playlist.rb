require 'httparty'
require 'pry-byebug'
# frozen_string_literal: true
class Playlist
  include HTTParty
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  base_uri 'api.spotify.com'

  def self.fetch(limit: 20, offset: 0)
    authorization_key = 'BQC0-UKu9I5q1qq2JZS4tnaM_53lM-HKt61DjbplDJb6x-7k30yIe8MvhKsY_LOqkD--5C1RQF75wzlIp3nTHot-rtWvDOGpOvsWz0uvJ4wJ6eJ5T36ZBLkwb_VMEewVAdm38171fyL7MAU5nl9ERukdRuGRT2y3JPEnhKn2Jzd2xwO7HxDwEMyd4sOttc5AFF2-VOSX1qlMZxQ'
    response = get('https://api.spotify.com/v1/me/playlists',
                   limit: limit, offset: offset,
                   headers: {
                     Authorization: "Bearer #{authorization_key}"
                   })
    JSON.parse(response.body).fetch('items').map do |item|
      Playlist.new(name: item.fetch('name'))
    end
  end
end
# Playlist.fetch.map { |playlist| playlist.name }
Playlist.fetch.map(&:name)
