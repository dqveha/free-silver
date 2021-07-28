require 'rspec'
require 'pg'
require 'album'
require 'song'
require 'artist'
require 'pry'

DB = PG.connect({ dbname: 'record_store_test', host: 'db', user: 'postgres', password: 'password' })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM albums *;")
    DB.exec("DELETE FROM songs *;")
    # DB.exec("DELETE FROM albums_artists *;")
  end
end
