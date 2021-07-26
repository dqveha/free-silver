class Album
  attr_accessor :name, :release_year
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @release_year = attributes.fetch(:release_year)
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      release_year = album.fetch("release_year").to_i
      albums.push(Album.new({:name => name, :id => id, :release_year => release_year}))
      end
    albums
  end

  def save
    result = DB.exec("INSERT INTO albums (name, release_year) VALUES ('#{@name}', '#{@release_year}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};") 
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};") # new code
  end

  def songs
    Song.find_by_album(self.id)
  end

  def self.alphabet
    self.all.sort_by {|album| album.name}
  end

  def self.chrono
    self.all.sort_by {|album| album.release_year}
  end

end
