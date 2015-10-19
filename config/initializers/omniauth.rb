require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, :clientkey, :clientsecret, scope: 'playlist-modify-public playlist-read-private user-library-read playlist-modify-private user-library-modify user-read-private playlist-read-collaborative'
end


