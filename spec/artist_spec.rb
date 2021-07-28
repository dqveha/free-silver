require 'rspec'
require 'album'
require 'song'
require 'artist'
require 'pry'
require('spec_helper')

describe '#Artist' do

  # describe('#update') do
  #   it("adds an album to an artist") do
  #     artist = Artist.new({:name => "John Coltrane", :id => nil, :album_id => nil})
  #     artist.save()
  #     album = Album.new({:name => "A Love Surpeme", :id => nil, :release_year => 2003, :cost => 1.0})
  #     album.save()
  #     artist.update({:album_name => "A Love Supreme"})
  #     expect(artist.albums).to(eq([album]))
  #   end
  # end

  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      expect(artist.albums).to(eq([album]))
    end
  end

  
end