require 'rspec'
require 'album'
require 'song'
require 'artist'
require 'pry'
require('spec_helper')

describe '#Album' do

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      album2.save()
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      album2 = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      expect(album).to(eq(album2))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album.update({:name => "Woah dude"})
      expect(album.name).to(eq("Woah dude"))
    end
  end

  describe('#delete') do
    it("deletes all songs belonging to a deleted album") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
      song.save()
      album.delete()
      expect(Song.find(song.id)).to(eq(nil))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
      song.save()
      song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end

  describe('.alphabet') do
    it("returns albums in alphabet order") do
      album = Album.new({:name => "Rawr", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album2 = Album.new({:name => "Awooooo", :id => nil, :release_year => 2003, :cost => 1.0})
      album2.save()
      album3 = Album.new({:name => "Blue", :id => nil, :release_year => 2003, :cost => 1.0})
      album3.save()
      expect(Album.alphabet()).to(eq([album2, album3, album]))
    end
  end

  describe('.chrono') do
    it('returns albums in chronological order') do
      album = Album.new({:name => "Rawr", :id => nil, :release_year => 2003, :cost => 1.0})
      album.save()
      album2 = Album.new({:name => "Awooooo", :id => nil, :release_year => 1974, :cost => 1.0})
      album2.save()
      expect(Album.chrono).to(eq([album2, album]))
    end
  end

  describe('.cost') do
    it('returns cheap/expensive albums ') do
      album = Album.new({:name => "Rawr", :id => nil, :release_year => 2003, :cost =>5.0})
      album.save()
      album2 = Album.new({:name => "Awooooo", :id => nil, :release_year => 1974, :cost => 2.0})
      album2.save()
      album3 = Album.new({:name => "Awooooo", :id => nil, :release_year => 1974, :cost => 3.0})
      album3.save()
      expect(Album.cost).to(eq([album2, album]))
    end
  end

  # describe('.random') do
  #   it('returns something random.. hopefully.. ') do
  #     album = Album.new({:name => "Rawr", :id => nil, :release_year => 2003, :cost =>5.0})
  #     album.save()
  #     album2 = Album.new({:name => "Awooooo", :id => nil, :release_year => 1974, :cost => 2.0})
  #     album2.save()
  #     album3 = Album.new({:name => "Awooooo", :id => nil, :release_year => 1974, :cost => 3.0})
  #     album3.save()
  #     expect(Album.find(Album.random()).to(eq([])))
  #   end
  # end

  describe('#artists') do
    it('returns artists from album') do
      album = Album.new({:name => "Rawr", :id => nil, :release_year => 2003, :cost =>5.0})
      album.save()
      artist = Artist.new({:name => "John Coltrane", :id => nil, :album_id => nil})
      artist.save()
      album.update({:artist_name => "John Coltrane"})
      artist2 = Artist.new({:name => "Black Betty", :id => nil, :album_id => nil})
      artist2.save()
      album.update({:artist_name => "Black Betty"})
      artist3 = Artist.new({:name => "Dude, wheres my dog", :id => nil, :album_id => nil})
      artist3.save()
      album.update({:artist_name => "Dude, wheres my dog"})
      expect(album.artists()).to(eq([artist, artist2, artist3]))
    end
  end
end
