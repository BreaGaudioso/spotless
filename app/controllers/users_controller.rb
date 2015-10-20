class UsersController < ApplicationController
  # before_action :prevent_login_signup

  def index
    @user = user
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user_playlists = spotify_user.playlists
    hashToken = spotify_user.to_hash["credentials"]["token"]
    puts spotify_user.to_hash
    hashID = spotify_user.to_hash["id"]
    if hashID.present? && hashToken.present?
      found_user = User.where(spotify_user_id:hashID).first
      if found_user
        getData(user.id)
        session[:user_id] = found_user["id"]
        user_playlists.each do |playlist|
          found_playlist = Playlist.where(spotify_playlist_id:playlist.id).first
          if found_playlist

          else
            new_playlist = found_user.playlists.create(name:playlist.name, spotify_playlist_id:playlist.id)
            tracks = RSpotify::Playlist.find(found_user[:spotify_user_id], playlist.id)
            if tracks.total != 0
              tracks.tracks_cache.each do |track|
                new_track = new_playlist.tracks.create(name:track.name, spotify_track_id:track.id)
                binding.pry
                new_album = Album.create(name:track.album.name, spotify_album_id:track.album.id, image_url:track.album.images[0]['url'])
                tracks.artists.each do |artist|
                  new_artist = new_track.artist.create(name:artist.name, spotify_artist_id:artist.id)
                end
              end
            end
          end
        end
        redirect_to users_path
      else
        user = User.create( spotify_user_id:hashID, spotify_auth_token:hashToken )
        if user.save
          session[:user_id] = user.id
          redirect_to users_path
        else
          redirect_to users_path
        end
      end
    end
  end

  def logout
    res = Typhoeus.get("https://www.spotify.com/logout")
    session[:user_id] = nil
    redirect_to :root
  end


  private
  def user
    @user ||=current_user
  end

  def get_spotify_data(user_id)
    user = User.find user_id
    # test2 = RSpotify::Playlist.find('donb91','10rjQcqX5eAW52R17NNYF0')

    data = spotify_user.playlists
    data.each do |playlist|
      puts playlist.id
    end
  end


end
