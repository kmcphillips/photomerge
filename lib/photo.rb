class Photo
  attr_reader :path, :camera, :exif

  def initialize(path, camera:)
    @path = File.new(path)
    @camera = camera
    @exif = MiniExiftool.new(@path.path)
  end

  def date
    exif.create_date
  end

  def date_with_offset
    date + camera.identity_photo_offset
  end

  def inspect
    "#<#{ self.class } path: #{ path.path }, camera: #{ camera.inspect }, exif: { date_time: #{ date }>"
  end
end
