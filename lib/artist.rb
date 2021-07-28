class Artist
  attr_accessor :name
  attr_reader :id, :album_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |album|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
      end
    artists
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(artist_to_compare)
    self.name() == artist_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    if artist
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
    # release_year = artist.fetch("release_year").to_i
    # cost = artist.fetch("cost").to_f
      Artist.new({:name => name, :id => id})
    else
      nil
    end
  end


  def delete
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:album_name)) && (attributes.fetch(:album_name) != nil)
      album_name = attributes.fetch(:album_name)
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  def albums
    albums = []
    results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
    results.each() do |result|
      album_id = result.fetch("album_id").to_i()
      album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
      name = album.first().fetch("name")
      albums.push(Album.new({:name => name, :id => album_id}))
    end
    albums
  end
end


  # def songs
  #   Song.find_by_album(self.id)
  # end

  # def self.alphabet
  #   self.all.sort_by {|album| album.name}
  # end

  # def self.chrono
  #   self.all.sort_by {|album| album.release_year}
  # end

  # def self.cost
  #   new_array = []
  #   album = self.all.sort_by {|album| album.cost}
  #   new_array.push(album[0],album[-1])
  # end  

  # def self.random
  #   random_id = rand(1..3)
  #   album = DB.exec("SELECT * FROM albums WHERE id = #{random_id};").first
  #   name = album.fetch("name")
  #   id = album.fetch("id").to_i
  #   release_year = album.fetch("release_year").to_i
  #   cost = album.fetch("cost").to_f
  #   Album.new({:name => name, :id => id, :release_year => release_year, :cost => cost})
  # end